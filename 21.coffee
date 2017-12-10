{_log,_print,assert} = require './util'

input = '''
move position 2 to position 6
move position 0 to position 5
move position 6 to position 4
reverse positions 3 through 7
move position 1 to position 7
swap position 6 with position 3
swap letter g with letter b
swap position 2 with position 3
move position 4 to position 3
move position 6 to position 3
swap position 4 with position 1
swap letter b with letter f
reverse positions 3 through 4
swap letter f with letter e
reverse positions 2 through 7
rotate based on position of letter h
rotate based on position of letter a
rotate based on position of letter e
rotate based on position of letter h
rotate based on position of letter c
move position 5 to position 7
swap letter a with letter d
move position 5 to position 6
swap position 4 with position 0
swap position 4 with position 6
rotate left 6 steps
rotate right 4 steps
rotate right 5 steps
swap letter f with letter e
swap position 2 with position 7
rotate based on position of letter e
move position 4 to position 5
swap position 4 with position 2
rotate right 1 step
swap letter b with letter f
rotate based on position of letter b
reverse positions 3 through 5
move position 3 to position 1
rotate based on position of letter g
swap letter c with letter e
swap position 7 with position 3
move position 0 to position 3
rotate right 6 steps
reverse positions 1 through 3
swap letter d with letter e
reverse positions 3 through 5
move position 0 to position 3
swap letter c with letter e
move position 2 to position 7
swap letter g with letter b
rotate right 0 steps
reverse positions 1 through 3
swap letter h with letter d
move position 4 to position 0
move position 6 to position 3
swap letter a with letter c
reverse positions 3 through 6
swap letter h with letter g
move position 7 to position 2
rotate based on position of letter h
swap letter b with letter h
reverse positions 2 through 6
move position 6 to position 7
rotate based on position of letter a
rotate right 7 steps
reverse positions 1 through 6
move position 1 to position 6
rotate based on position of letter g
rotate based on position of letter d
move position 0 to position 4
rotate based on position of letter e
rotate based on position of letter d
rotate based on position of letter a
rotate based on position of letter a
rotate right 4 steps
rotate based on position of letter b
reverse positions 0 through 4
move position 1 to position 7
rotate based on position of letter e
move position 1 to position 7
swap letter f with letter h
move position 5 to position 1
rotate based on position of letter f
reverse positions 0 through 1
move position 2 to position 4
rotate based on position of letter a
swap letter b with letter d
move position 6 to position 0
swap letter e with letter b
rotate right 7 steps
move position 2 to position 7
rotate left 4 steps
swap position 6 with position 1
move position 3 to position 5
rotate right 7 steps
reverse positions 0 through 6
swap position 2 with position 1
reverse positions 4 through 6
rotate based on position of letter g
move position 6 to position 4
'''

test = '''
swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d
'''


def = (l,r,f,g)->
	[l,r,f,g]

swap = (a,b,w)->
	[w[a],w[b]] = [w[b],w[a]]
	w

swapw = (a,b,w)->
	a=w.indexOf a
	b=w.indexOf b
	assert a>=0 and b>=0, 'invalid index',a,b
	swap a,b,w

rotatel = (n,w)->
	n%=w.length
	w[n..].concat w[...n]

rotater = (n,w)->
	rotatel -n,w

reverse = (a,b,w)->
	assert a<b, 'incorrect range'
	w[...a].concat w[a..b].reverse().concat w[b+1..]

move = (a,b,w)->
	if a<b
		w[...a].concat w[a+1..b].concat [w[a]].concat w[b+1..]
	else
		w[...b].concat [w[a]].concat w[b...a].concat w[a+1..]

map1 = for i in [0...8]
	j=i
	++i if i>=4
	(j+i+1)%8

map2 = '........'.split ''
for v, i in map1
	map2[v]=i

rotatew = (a,w)->
	i=w.indexOf a
	rotater map1[i]-i,w

rotatewb = (a,w)->
	i=w.indexOf a
	rotater map2[i]-i,w

cmds = [
	def 2, /swap position (\d+) with position (\d+)/, swap, swap
	def 2, /swap letter (\w) with letter (\w)/, swapw, swapw
	def 1, /rotate left (\d+) steps*/, rotatel, rotater
	def 1, /rotate right (\d+) steps*/, rotater, rotatel
	def 1, /rotate based on position of letter (\w)/, rotatew, rotatewb
	def 2, /reverse positions (\d+) through (\d+)/, reverse, reverse
	def 2, /move position (\d+) to position (\d+)/, move, (a,b,w)->move b,a,w
]

compile = ( input, reversed )->
	list = input.split '\n'
	list.reverse() if reversed
	for l in list
		code = undefined
		for c in cmds when r = c[1].exec l
			code = c[2+!!reversed].bind undefined, (r[1..c[0]].map (a)->isNaN(+a) and a or +a)...
			break
		assert code, 'unknown instruction', l
		code



exec = ( prog, w )->
	w = w.split ''
	for p in prog
		w = p w
	w.join ''

do ->
	try

		_log.cyan map1
		_log.red map2

		prog = compile test
		_log.cyan exec prog, 'abcde'

		prog = compile input
		_log.yellow exec prog, 'abcdefgh'

		prog = compile input, yes
		_log.yellow exec prog, 'fbgdceah'

	catch e
		_log.red e
	return
