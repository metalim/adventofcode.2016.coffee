_log = require 'ololog'

input = '''
'''

parse = ( input )->

exec = ( )->

try
	_log.darkGray v = parse input
	_log.yellow exec v

catch e
	_log.red e
