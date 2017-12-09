_log = require 'ololog'

input = '''
Disc #1 has 13 positions; at time=0, it is at position 1.
Disc #2 has 19 positions; at time=0, it is at position 10.
Disc #3 has 3 positions; at time=0, it is at position 2.
Disc #4 has 7 positions; at time=0, it is at position 1.
Disc #5 has 5 positions; at time=0, it is at position 3.
Disc #6 has 17 positions; at time=0, it is at position 5.
'''.split '\n'


parse = ( input )->
	spec = []
	for l in input
		r = /#(\d+) has (\d+) .* (\d+)\./.exec l
		spec[+r[1]] = p:+r[3],of:+r[2]
	spec

find_time = ( spec )->
	for t in [0..10000000]
		hit = no
		for d, i in spec when d?
			if (d.p+t+i)%d.of
				hit = yes
				break
		if not hit
			return t
	return
		
do ->
	try
		spec = parse input
		_log.yellow find_time spec

		spec.push p:0,of:11
		_log.yellow find_time spec

	catch e
		_log.red e
	return
