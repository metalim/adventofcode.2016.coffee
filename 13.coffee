_log = require 'ololog'

generate = ( x,y, magic )->
	key = x*x + 3*x + 2*x*y + y + y*y + magic
	bin = key.toString 2
	ones = 0
	for c in bin when c is '1'
		++ones
	'.#'[ones%2]
	
cross = [[1,0],[-1,0],[0,1],[0,-1]]

walk_around = ( start, magic, cb )->
	map = {}
	map[start[0]]={}
	map[start[0]][start[1]]=0
	next = [start]
	step = 0
	while next.length
		++step
		_log.darkGray step, next.length
		cur = next
		next = []
		for p in cur
			for d in cross
				x = p[0]+d[0]
				y = p[1]+d[1]
				if x<0 or y<0
					continue

				if not map[x]?[y]?
					map[x]?={}
					map[x][y] = generate x,y, magic
				if map[x][y] is '.'
					if cb x, y, step
						map[x][y] = '+'
						return map
					map[x][y] = step
					next.push [x,y]
	map

find_shortest_route = ( start, end, magic, dump_at )->
	w=h=0
	found = undefined
	visited = 1
	map = walk_around start, magic, ( x, y, step )->
		++visited
		#_log 'step', step, 'visited', visited, 'pos', x, y
		if step is dump_at
			#dump_after = Infinity
			_log.green visited
		w=x if w<x
		h=y if h<y
		if x is end[0] and y is end[1]
			found = step
			return yes
		return

	_log.cyan w, h
	for y in [0..h]
		_log (for x in [0..w]
			('  '+(map[x][y] ? '  ').toString())[-3..]
		).join ''
	found

do ->
	try
		magic = 1352
		_log.yellow find_shortest_route [1,1], [31,39], magic, 50

	catch e
		_log.red e
	return
