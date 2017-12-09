{_log} = require './util'
_print = _log.noLocate

input = '''
^.^^^..^^...^.^..^^^^^.....^...^^^..^^^^.^^.^^^^^^^^.^^.^^^^...^^...^^^^.^.^..^^..^..^.^^.^.^.......
'''

count_all_safe = ( seed, num )->
	_print seed
	safe = 0
	for c in seed when c is '.'
		++safe
	next = seed.split ''
	while --num > 0
		_print.clear "#{num}: #{safe}" unless num%100
		cur = next
		next = for i in [0...cur.length]
			l = cur[i-1] is '^'
			r = cur[i+1] is '^'
			v = l^r
			safe += v^1
			'.^'[v]
	_print.clear()

	safe


do ->
	try
		_print.cyan count_all_safe '..^^.', 3
		_print.cyan count_all_safe '.^^.^.^^^^', 10
		_print.yellow count_all_safe input, 40
		_print.yellow count_all_safe input, 400000

	catch e
		_log.red e
	return
