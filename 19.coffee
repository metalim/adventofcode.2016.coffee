{_log} = require './util'
_print = _log.noLocate

find_greedy_elf1 = ( num )->
	els = [1..num]
	j = 0
	while els.length>1
		num = els.length
		_print.darkGray num, els[..4].join ','
		els = for i in [j...els.length] by 2
			els[i]
		j = (j+num)%2
	els[0]


assert = ( cond, msg... )->
	if not cond
		_print.red msg...
	return

#
# mark and sweep in each cycle
#
skip = 0
find_greedy_elf2 = ( num, get_distance )->
	els = [1..num]
	while els.length>1
		num = els.length
		_print.darkGray num, els[..4].join ','
		dirty = 0
		for c, i in els
			if c
				_print.clear i, num unless skip++%10000
				d = get_distance num
				j = (i+d+dirty)%els.length
				assert els[j], 'error', i, j, els[j-1..j+1], num, dirty
				els[j]=0
				--num
				++dirty
			else
				--dirty
		_print.clear i, num, '\n'
		els = (c for c in els when c)


	els[0]






do ->
	try
		_log.yellow find_greedy_elf1 3018458
		_log.yellow find_greedy_elf2 3018458, (n)->1
		_log.yellow find_greedy_elf2 3018458, (n)->n//2

	catch e
		_log.red e
	return
