{_log} = require './util'
_print = _log.noLocate
assert = ( cond, msg... )->
	if not cond
		_print.red msg...
	cond

input = '''
'''

parse = ( input )->

exec = ( )->

do ->
	try
		_log.darkGray v = parse input
		_log.yellow exec v

	catch e
		_log.red e
	return
