_log = require 'ololog'







input = '''
cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 13 c
cpy 14 d
inc a
dec d
jnz d -2
dec c
jnz c -5
'''

parse = ( input )->
	input.split('\n').map (a)->a.split ' '

exec = ( prog, st )->
	_log st
	cycles = 0
	i = 0
	while 0 <= i < prog.length
		++cycles
		l = prog[i]
		#_log i, l, st
		switch l[0]
			when 'cpy'
				st[l[2]] = st[l[1]] ? +l[1]
			when 'inc'
				++st[l[1]]
			when 'dec'
				--st[l[1]]
			when 'jnz'
				if ( st[l[1]] ? +l[1] ) isnt 0
					i += st[l[2]] ? +l[2]
					continue
			else
				throw new Error 'invalid instruction', l
		++i
	_log cycles, 'ticks'
	st

test = '''
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a
'''

try
	st =
		a:0
		b:0
		c:0
		d:0
	prog = parse input
	st = exec prog, st
	_log.yellow st

	st =
		a:0
		b:0
		c:1
		d:0
	st = exec prog, st
	_log.yellow st

catch e
	_log.red e
