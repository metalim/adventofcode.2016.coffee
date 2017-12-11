{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

class Solver
	constructor: ( @input )->
	solve: ->

do ->
	input = '''
	'''

	try
		s = new Solver input
		_log.yellow s.solve()

	catch e
		_log.red e
	return
