_log = require 'ololog'
crypto = require 'crypto'

room = '''
#########
#S| | | #
#-#-#-#-#
# | | | #
#-#-#-#-#
# | | | #
#-#-#-#-#
# | | |  
####### V
'''

md5 = ( str )->
	crypto.createHash('md5').update(str).digest 'hex'

DIR =
	U: [0,-1,0]
	D: [0,1,1]
	L: [-1,0,2]
	R: [1,0,3]

find_path = ( code, longest )->
	next = '':[0,0]
	next_len = 1
	step = 0
	max = undefined

	while next_len
		++step
		# if longest
		# 	_log.darkGray 'step', step, 'len', next_len

		cur = next
		next = {}
		next_len = 0

		for k,[x,y] of cur
			h = md5 code+k
			for d,[dx,dy,i] of DIR when 0<=(nx=x+dx)<=3 and 0<=(ny=y+dy)<=3 and h[i] in 'bcdef'
				nk = k+d
				if nx is 3 and ny is 3
					if longest
						max = nk
					else
						return nk
				else
					next[nk]=[nx,ny]
					++next_len
	max

do ->
	try
		# _log md5 'hijkl'
		# _log md5 'hijklD'
		# _log md5 'hijklDR'
		# _log md5 'hijklDU'
		# _log md5 'hijklDUR'

		_log.red find_path 'hijkl'
		_log.cyan find_path 'ihgpwlah'
		_log.cyan find_path 'kglvqrro'
		_log.cyan find_path 'ulqzkmiv'
		_log.yellow find_path 'ioramepc'

		_log.cyan find_path('ihgpwlah', yes).length
		_log.cyan find_path('kglvqrro', yes).length
		_log.cyan find_path('ulqzkmiv', yes).length
		_log.yellow find_path('ioramepc', yes).length

	catch e
		_log.red e
	return
