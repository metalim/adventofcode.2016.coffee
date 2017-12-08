_log = require 'ololog'
{permute} = require './util'

input = '''
The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, and a strontium generator.
The second floor contains a plutonium-compatible microchip and a strontium-compatible microchip.
The third floor contains a promethium generator, a promethium-compatible microchip, a ruthenium generator, and a ruthenium-compatible microchip.
The fourth floor contains nothing relevant.
'''

from_id = ( id )->
	id.split('').map (a)->+a

to_id = ( st, el )->
	st.join('')+el

# this is the key to solve
is_valid = ( st, fl )->
	if not fl?
		throw new Error 'invalid floor'
	its = [0,0]
	for v, i in st when v is fl
		#_log v, i
		++its[i%2]
	#_log its
	if its[0] and its[1]
		for v, i in st by 2 when v is fl and v isnt st[i+1]
			return no
	yes

move = ( st, fl, p )->
	st = st[..]
	for i in p
		st[i]=fl
	st

find_shortest_path = ( init_id, goal )->
	step = 0
	next = {}
	next[init_id] = 0
	next_len = 1
	dump = 0
	visited = {}
	while next_len > 0
		_log.darkGray step, next_len
		++step
		cur = next
		next = {}
		next_len = 0

		#
		# for all current states
		#
		for id of cur
			st = from_id id
			el = st.pop()

			#
			# permute new states
			#
			ins = (i for v, i in st when v is el)
			out = permute.minmax_of 1, 2, ins, ( p )->
				for el2 in [el-1,el+1] when 1<=el2<=4
					st2 = move st, el2, p
					id2 = st2.join('')+el2
					if next[id2]? or visited[id2]?
						continue
					unless is_valid(st2, el) and is_valid st2, el2
						continue
					if id2 is goal
						return step
					next[id2] = step
					visited[id2] = step
					++next_len
				return

			if out
				return out
	_log.red 'path not found'
	return


try
	id = '11121233331'
	goal = '44444444444'
	_log.yellow find_shortest_path '11121233331', '44444444444'
	_log.yellow find_shortest_path '111111121233331', '444444444444444'

catch e
	_log.red e
