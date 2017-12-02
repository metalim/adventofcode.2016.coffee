_log = console.log.bind console

path = 'R3, R1, R4, L4, R3, R1, R1, L3, L5, L5, L3, R1, R4, L2, L1, R3, L3, R2, R1, R1, L5, L2, L1, R2, L4, R1, L2, L4, R2, R2, L2, L4, L3, R1, R4, R3, L1, R1, L5, R4, L2, R185, L2, R4, R49, L3, L4, R5, R1, R1, L1, L1, R2, L1, L4, R4, R5, R4, L3, L5, R1, R71, L1, R1, R186, L5, L2, R5, R4, R1, L5, L2, R3, R2, R5, R5, R4, R1, R4, R2, L1, R4, L1, L4, L5, L4, R4, R5, R1, L2, L4, L1, L5, L3, L5, R2, L5, R4, L4, R3, R3, R1, R4, L1, L2, R2, L1, R4, R2, R2, R5, R2, R5, L1, R1, L4, R5, R4, R2, R4, L5, R3, R2, R5, R3, L3, L5, L4, L3, L2, L2, R3, R2, L1, L1, L5, R1, L3, R3, R4, R5, L3, L5, R1, L3, L5, L5, L2, R1, L3, L1, L3, R4, L1, R3, L2, L2, R3, R3, R4, R4, R1, L4, R1, L5'

dirs = [
	[0,1]
	[1,1]
	[0,-1]
	[1,-1]
]
turns =
	R: 1
	L: -1


street_len = ( pos )->
	Math.abs(pos[0]) + Math.abs pos[1]

length = ( path )->
	moves = path.split ', '
	pos = [0,0]
	dir = 0
	for m in moves
		turn = m[0]
		len = +m[1..]
		dir += turns[turn]
		dir %%= 4
		pos[dirs[dir][0]] += dirs[dir][1] * len

	street_len pos

cross = ( path )->
	moves = path.split ', '
	visited = {}
	pos = [0,0]
	dir = 0
	for m in moves
		turn = m[0]
		len = +m[1..]
		dir += turns[turn]
		dir %%= 4
		for i in [1..len]
			pos[dirs[dir][0]] += dirs[dir][1]
			key = "#{pos[0]}:#{pos[1]}"
			if visited[key]
				#_log 'cross at', pos
				return street_len pos
			visited[key] = yes
	throw new Error 'no crosses'
	return


_log length path
_log cross path
