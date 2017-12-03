_log = console.log.bind console
crypto = require 'crypto'

str = 'cxdnnyjw'

get_code = ( door )->
	i = 0
	code = ''
	while code.length<8
		val = "#{door}#{i}"
		hash = crypto.createHash('md5').update(val).digest 'hex'
		if hash[...5] is '00000'
			code += hash[5]
			_log i, hash, code, val
		i++
	code

get_code2 = ( door )->
	i = 0
	code = '        '.split ''
	filled = 0
	while filled < 8
		val = "#{door}#{i}"
		hash = crypto.createHash('md5').update(val).digest 'hex'
		if hash[...5] is '00000'
			pos = +hash[5]
			char = hash[6]
			_log i, hash
			if 0<=pos<=7 and code[pos] is ' '
				code[pos] = char
				_log code
				filled++
		i++
	code.join ''

_log get_code str
_log get_code2 str
