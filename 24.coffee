{_log,_print,assert,permute} = require './util'
ansi = require('ansicolor').nice

input = '''
###################################################################################################################################################################################
#.........#...#.............#...#3#.#.....#...........#.........#.#...#.......#.#.#...#...#.................#...........#.#...#.#.......#.......#.......#...#...#.....#.....#.....#
#.#.#.#.#.#.#########.#.#.###.#.#.#.###.###.#.###.#.#.#.###.#.###.#.#.#.#.#####.#.#.#.#.#.#.###.#.#.#.#.#.#.#.###.#.#.###.#.#.#.#####.#.#.#.###.#.#.#.#.#.###.#.###.###.###.###.#.#
#...#...#...#.......#...#.#.#.....#...#.....#.........#.......#.#...#...#.#.............#...#.......#.#.#...#.#.....#.......#...#.....#...#...........#...#...#.#...............#2#
#.###.#.#.#####.###.###.#.#.#.#.###.#.#.#####.#######.#.###.###.#.#.#.#.#.#####.###.###.#.#.#####.#.###.#.###.#.#.#.#.#.#######.#######.#.#.###.###.###.#.#.#.#.#.#.###.#.###.#.###
#.......#.........#.#.#...#...#...#.....#.#.............#.....#...#.......#.#.....#...#...#.......#.............................#.#...#...#...#.....#...#.......#.......#.......#.#
#.###.#.#.#########.#.#.#.#.#.#.#.#.#.#.#.#.#.#.###.#.#.#####.#.#.#######.#.#.#.#.#.#.#####.#.###.#.#####.#.###.###.#.#.###.###.#.#.#.#####.#.###.#.#.#.#######.###.#.#.#.###.###.#
#...#.#...#...#...#...#.#...#.....#...#...........#.....#.........#.#...#...#...#.#...#.......#...#.#.....#.#.....#...#.#.......#.#.#.......#.......#...........#.#.#...#.#.......#
#.#.#.###.###.#.#.#######.#.#.#.#.#.#.###.###########.#.#.#####.###.#.#.#####.#.#.#.#####.###.#.###.#####.###.#####.#########.#.###.#.###.#.#.#.#.###.###.#.#####.#.#.#.#.#.###.#.#
#.......#.......#...........#...#.#...#.............#.#.#...#...#.....#...#...#.#...#...#.......#.#.#.#...#.....#.#.#.........#...#...#.....#.#...........#.#.......#.#.#...#...#.#
#.#.#.###.#####.#.#####.#.###.#.#.#.###.#.#.#.###.###.#.#####.###.#####.#.#.#####.#.#.#.#######.#.###.#.###.#####.#.#####.#.#.#####.#.#.#.#.###.#.#######.#.#.#.###########.#.#.#.#
#.#.#.....#.#1..........#.#...#...#.....#.........#...............#.#...#.....#...#.......#...........#.#...#.#.....#.............#.............#.....#...#.....#...#.....#.#.....#
#.#.###.#.#.#####.#.#.#.###.#####.#.#.#.###.###.#.#.#.#####.#.#.###.#.#.#####.#.#.#.#.#.#.###.#.###.#.#.#.#.#.#.###.#.#.#####.###.###.###.#.#.#.###.#.#.#.#.#.###.#.#.#####.#####.#
#...#...#.#...#.#.#.#.#.......#.....................#.#...............#.......#.#...#.#.#.....#.#.#...#...#.#.......#.....#.#...#.........#.#.#...#.........#.............#.....#.#
#.###.###.###.#.#.###.#.#####.#.#####.###.###########.###.#.#.#####.#.#.#.###.###.#.#.#.#.###.#.#.#.#.###.#.###.#.#########.#.#.#.#.###.#.#.#.#.#.#.#.#.#.###.###.#####.#.#####.###
#.....#.#.......#.#.#.....#...#.......#...#.#...#.............#.#.#.....#.........#...#.#.........#.#.#.#...#.#...#...#.......#.....#.#.....#.#.#.......#.#...#.#.....#.......#...#
#.#.###.#.#######.#.#.#.###.#.###.###.#####.#.#.#.#.###.###.###.#.#.#####.#.#####.#.#.#.#.#.#########.#.#.#.#.#.#.#.#.#.###.#.###.#.#.###.###.#.#######.#.#.#.#.#.###.#.#.#.#.###.#
#.#.#.......#...#...#.#.#.#.....#.....#...#...#.....#...#...#...#...........#...........#.........#.#.....#.....#.......#...#...#...#.#...#.#.#.........#...#.....#.#...#.#.....#.#
#.#.#.#####.#.#.#.###.###.#.#.#####.#.###.#.#.#####.#.#####.#.#.#.#####.###.#.#.#.#.###.#.#.#.#.#.#.#.###.#.#####.###.###.#.#.#.#.#.#.#.#.#.###.###.#.#######.#####.###.#.###.###.#
#.#.......#.#...#.#...#.#.#.......#...#.....#.........#.....#.#.....#...#...#.#.#...#.....#...#...#...#.....#.......#.#.#...#.#.........#...#.#..4#.#.#.#.#.....#.....#.........#.#
#.###.#.#.#.###.#.#.###.#.#######.#.#.###.#.###.#.#.#.#.#.#.###.#####.#.###.#######.#####.###.#.#.#.#.#.###.#.#####.#.#.#.#.#.#.#.#.#.#.#.#.#.#######.#.#.#.#.#.#.#.#.#.#.###.#.#.#
#0#...#.#.#.....#...#...#.#...#...#...#...#.......#.#.#.....#...#...#...#...#...#...#.........#.......#...#.......#...#...#...#.......#...#...............#.....#...#...#...#.#...#
###.#.#.###.###########.#.#####.###.###.###.###.###.#.###.#.#.#.#.#.#.#.#.#.#.###.#.###.#.#.#.#####.#.#.#.#.#.#.#.#.#.#.#.###.#####.#.#####.#.#.#.#####.#.#.#####.#####.#.#.#.#.###
#...#.#...#.......#...#...........#...#.....#...#...#.#.........#.....#.#...#.......#.....#.#.#.........#.........#...#.#.#...#.#.....#.....................#...............#.....#
###.#.#.#.#.#.###.#.#.#.#.#######.#.#.###.###.#.#.#####.###.###.###.###.#.#.#.#.#######.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.###.#.#####.###.#######.###.###.#.###.###.###.###.#.#.#
#...#.............#.#...........#.#.#.....#.....#.......#.#.....#...#.........#.....#.......#.....#...#.....#...#.......#...#...#.#.........#...#...........#.......#...#.......#.#
###.#.#########.#.#.#####.#.#.#.#.#.#.###.#.#######.#.#.#.#.#.#####.#.#.#.#####.#.#.#.#####.#######.#.#.#.#.#.#####.#.#.#.#####.#.#.###.#######.#######.#.#.###.#.#.#.#.#.#.###.#.#
#.#...............#.#.......#.....#.................#...#.#.#.......#...#.......#.#.#...#.#.......#...#.....#.....#...#.#.......#.#.#.....#.....#.....#.#...#.#...#...#.#...#.#.#.#
#.#.#.###.#.#.#.#.#.#.#.#.#.#########.#.#.#.#.#.#.#.#.#.#.#.###.#.#.#.###.#.#.#.#.#.###.#.#.###.#.#.###.###.#.#.#####.#####.#####.#.#.#.#.#.#.###.#.#.#.###.#.#.#.#.###.#.#.#.#####
#...#.#.....#...#.............#.#.#.#.........#.#...#.#.....#.......#...#.#.#.....#.......#...#...#...........#.....#.#.......#...#...#.#.........#...#...#.....#.......#...#.....#
###.#.#.#.#.#.#.###.#.###.#.###.#.#.#.#.###.#.###.#.#.#####.###.###.#.#.#.###.#.#.###.###.###.#.#.#.#.###.#####.###.#####.#.#.###.###.#####.#####.#.#.#######.###.###.###.#.#.#.#.#
#...#.#.....#.........#.......#.#...#.......#...#...#...........#.....#.......#...........#.......#...#...#.....#.....#...#.......#.#.#...#.#.....#.........#.....#...#.#...#.#...#
###.###.###.###.#.#####.###.#.#.#.#.#.###.###.###.###.#.#####.#.#.#.#.###.#.#.###.#.###.###.#.#.###.###.#.#.#.#.#.#.#.#.#.#.#.#.###.#.###.#.###.#.#.#####.#.#####.#.#.#.#####.#.#.#
#.#.#...#.#.#...................#.......#.#.#.#.#.....#.#.#.....#...#.......#.#...#.......#.....#...#.....#...#...#.#...#...#.........#...#...#...........#.........#.#..5#...#...#
#.#.#.###.#.###.#####.#.#.###.#.#####.#.#.#.#.#.#.###.#.#.#.#######.###.#.#.#.#.#.###.#.#.#.###.#.#####.#.#.#.#####.#.###.#.#.###.###.#.###.#.#.###########.#.#######.#.#.#.###.###
#...#.#.#...#.#.................#.#.....#.#.........#.....#.#.#...#.#.........#...#.#...#.#.........#...#...#.....#.#.#.#.....#...#.#.....#.#.............#.#...#.#.#.....#...#...#
#.#.###.#.#.#.#.#.#.#.#.###.###.#.#.#######.#######.###.#.#.#.###.#.#.#####.###.###.#####.#.#####.#.#.#.#.#.#.###.#.#.#.#.###.#.#.#.#.#.#.#.#####.#.#.#.#.###.#.#.#.#.#####.###.#.#
#...#.....#.....#.....#.#...#...#...............#...#...#...#.....#...#.#.....#.#.#...#...#.#...#...#.....#...#...#...................#.........#...#.........#.#...#.......#...#.#
###.#.###.#.#.#.###.#.#.#.#.#.###.###.#.###.###.#.###.#.#######.#.#.#.#.#.#####.#.#.#.#.#.###.#.#.#.#####.#.#.###.#.#######.#######.###.#######.#.#.#.#.###.###.###.#.#.#.#.#.#.#.#
#.....#7..#.#.#...........#.#...#.........#.....#.#.#...#.....#.............#...#...#...#.#.#...#.......#...#.....#.#.......#.#.....#...#...#...#...#...#...#.#.....#.#.......#.#.#
#.#.#.#.#.#.#.#.#.#.###.#####.#.#############.#.###.#.#.#.#.###.###.#######.#.#.###.#.###.#.###.#######.###.###.#.#.###.#.#.#.#.#.###.###.###.#.#.###.#.#.#.#.#.#.###.#.###.#.#.###
#...#.....#.#...#.#.....#.....#...#...#.......#6#.......#.#.......#.#.........#...#.#.....#.....#.#.......#.#.......#.......#.....#.....#.....#...#.#.#.#...#.#...#.#...#...#.#.#.#
###################################################################################################################################################################################
'''

class Solver
	constructor: ( @input )->
		@reset_dots()
		@find_distances()
		return

	reset_dots: ->
		@dots = []
		for l, y in @input.split '\n'
			for c, x in l.split '' when c not in '#.'
				@dots[+c] = [x,y,+c,[]]
		return

	reset_map: ->
		@map = for l, y in @input.split '\n'
			l.split ''
		return

	find_distances: ->
		#
		# 1. find distances between dots
		#
		DIR = [[1,0],[-1,0],[0,1],[0,-1]]
		for dot, idot in @dots #when dot?
			@reset_map()
			next = [dot]
			step = 0
			@map[dot[1]][dot[0]] = 0
			while next.length
				++step
				cur = next
				next = []
				if idle 200
					_log.clear.darkGray 'dot', idot, 'step', step, 'length', cur.length

				for [cx,cy] in cur
					for d in DIR
						x=cx+d[0]
						y=cy+d[1]
						v=@map[y]?[x] ? '#'
						if v is '#' or typeof v is 'number'
							continue
						next.push [x,y]
						@map[y][x] = step
						iv = +v
						if not isNaN iv
							@dots[iv][3][idot] = step
							@dots[idot][3][iv] = step
		return

	find_shortest_path: ( return_to_0 )->
		#
		# 2. permute dots for shortest path
		#
		min = Infinity
		permute @dots[1..], ( p )=>
			if return_to_0
				p.push @dots[0]
			if idle 200
				_log.clear.darkGray (d[2] for d in p).join ','
			len = 0
			for d2, i in p
				d1=p[i-1] ? @dots[0]
				len+=d1[3][d2[2]]
			min = len if min > len
			return
		_log.clear ''
		min

idle_t = Date.now()
idle = ( dt )->
	t = Date.now()
	if res = t-idle_t >= dt
		idle_t = t
	res

do ->
	try
		s = new Solver input
		_log.yellow 'without return', s.find_shortest_path()
		_log.yellow 'with return', s.find_shortest_path yes

	catch e
		_log.red e
	return
