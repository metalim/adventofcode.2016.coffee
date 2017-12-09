_log = require 'ololog'


get_check = ( data )->
	for c, i in data by 2
		1^c^data[i+1]

find_checksum = ( seed, len )->
	data = seed.split('').map (a)->+a
	while data.length < len
		inv = data[..].reverse().map (a)->1-a
		data = data.concat [0].concat inv

	#_log data.length, data.join ''
	data = data[0...len]
	#_log data.length, data.join ''

	check = get_check data
	#_log check.length, check.join ''
	while check.length%2 is 0
		check = get_check check
		#_log check.length, check.join ''
	check.join ''

do ->
	try
		seed = '11101000110010100'
		_log.yellow 272, find_checksum seed, 272
		_log.yellow 35651584, find_checksum seed, 35651584
	catch e
		_log.red e
	return
