{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice






input = '''
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 86 c
jnz 78 d
inc a
inc d
jnz d -2
inc c
jnz c -5
'''

parse = ( input )->
	input.split('\n').map (l)->
		l.split(' ').map (a)->
			if isNaN +a then a else +a

last = undefined
diff = ( st )->
	s = JSON.stringify st
	ss = last
	if last?
		last = s
		(s.split('').map (c,i)->if c is ss[i] then c.darkGray else c.yellow).join ''
	else
		last = s
		s.green

swap =
	inc: 'dec'
	dec: 'inc'
	tgl: 'inc'

	cpy: 'jnz'
	jnz: 'cpy'

get = ( s, v )->
	if typeof v is 'number' then v else s[v]
	#if isNaN v then s[v] else v # slower
	#s[v] ? v # slowest

exec = ( prog, st )->
	_log st
	cycles = 0
	i = 0
	dump = Date.now()
	dump_cycles = 0
	while 0 <= i < prog.length
		++cycles
		l = prog[i]
		t = Date.now()
		if t - dump > 1000
			_log.clear cycles, diff(st), i, l, cycles - dump_cycles
			dump = t
			dump_cycles = cycles
		switch l[0]
			when 'cpy'
				if typeof l[2] is 'string'
					st[l[2]] = get st, l[1]
				else
					_log.red l
			when 'inc'
				if typeof l[1] is 'string'
					++st[l[1]]
				else
					_log.red l
			when 'dec'
				if typeof l[1] is 'string'
					--st[l[1]]
				else
					_log.red l
			when 'jnz'
				if ( st[l[1]] ? l[1] ) isnt 0
					i += get st, l[2]
					continue
			when 'tgl'
				d = get st, l[1]
				l2 = prog[i+d]
				_log.cyan '\nreplace', l2, i, d, i+d
				if l2?
					l2[0] = swap[l2[0]] ? _log.error 'unknown command', l[1], l2[0]
					_log.green '.......', l2
			else
				throw new Error 'invalid instruction', l
		++i
	_log.clear cycles, diff(st), i, l, '\n'
	st

do ->
	try
		_log.darkGray pr = parse input
		_log.yellow exec pr, {a:7,b:0,c:0,d:0}

		_log.darkGray pr = parse input
		_log.yellow exec pr, {a:12,b:0,c:0,d:0}

	catch e
		_log.red e
	return
