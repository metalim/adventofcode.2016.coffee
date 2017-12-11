{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
cpy a d
cpy 15 c
cpy 170 b
inc d
dec b
jnz b -2
dec c
jnz c -5
cpy d a
jnz 0 0
cpy a b
cpy 0 a
cpy 2 c
jnz b 2
jnz 1 6
dec b
dec c
jnz c -4
inc a
jnz 1 -7
cpy 2 b
jnz c 2
jnz 1 4
dec b
dec c
jnz 1 -4
jnz 0 0
out b
jnz a -19
jnz 1 -21
'''

class Solver
	constructor: ( @input )->
		@prog = @input.split('\n').map (l)->l.split(' ').map (v)->if isNaN +v then v else +v
		@compile()
		return

	compile: ->
		@bin = @prog.map (l)=>
			id = "#{l[0]}_"
			for a in l[1..]
				id = id + if typeof a is 'number' then 'i' else 's'
			_log.cyan 'compiling', l, id

			assert @cmd[id], 'uknown instruction', id, l
			[ @cmd[id], l[1..], l[0] ]
		return

	reset_out: ->
		@break = no
		@out_len = 0
		@signal = 1

	out: (a)=>
		if a is @signal
			@break = yes
		else
			@signal = a
			++@out_len
		return

	exec: ( a )->
		@reg = {a,b:0,c:0,d:0,i:0,out:@out}
		tick = 0
		@reset_out()
		while 0<=(i=@reg.i)<@bin.length and not @break
			++tick
			c=@bin[i]
			if idle 1000
				_log.darkGray.clear tick, @out_len, JSON.stringify(@reg), c[2], c[1]
			c[0].apply @reg, c[1]
			++@reg.i
		_log.clear ''
		return

	find_min_a: ->
		a = 0
		while yes
			++a
			_log.darkGray 'a =',a
			@exec a
			_log 'len', @out_len
		return


	cmd:
		cpy_ss: (a,b)->
			@[b]=@[a]
			return
		cpy_is: (a,b)->
			@[b]=a
			return

		inc_s: (a)->
			++@[a]
			return
		dec_s: (a)->
			--@[a]
			return

		jnz_si: (a,b)->
			if @[a]
				@i+=b-1
			return
		jnz_ii: (a,b)->
			if a
				@i+=b-1
			return

		out_s: (a)->
			@out @[a]
			return

idle_t = Date.now()
idle = ( dt )->
	t = Date.now()
	if res = t-idle_t >= dt
		idle_t = t
	res


do ->

	try
		s = new Solver input
		s.find_min_a()

	catch e
		_log.red e
	return
