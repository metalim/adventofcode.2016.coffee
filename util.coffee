_render_t = Date.now()
_render = (s,{idle})->
	if idle?
		now = Date.now()
		if now - _render_t < idle
			return
		_render_t = now
	process.stdout.cursorTo 0
	process.stdout.write s
	process.stdout.clearLine 1
	return

exports.trace = exports._trace = _trace = require 'ololog'
.methods Object.defineProperties {
		idle: (t)-> @configure render: idle:t
	},
	clear:
		enumerable: yes
		configurable: yes
		get: -> @configure render: _render

exports._log = exports.log = _log = _trace.noLocate

exports.assert = assert = ( cond, msg... )->
	unless cond
		_trace.red msg...
		throw new Error 'assertion failed'
	cond

#
# fast array permutation
#
permute = exports.permute = ( arr, cb )->
	permutation = arr[..]
	length = permutation.length
	c = new Array(length).fill 0
	i = 1
	result = [permutation[..]] unless cb?
	#k, p;

	while i < length
		if c[i] < i
			k = i % 2 and c[i]
			p = permutation[i]
			permutation[i] = permutation[k]
			permutation[k] = p
			++c[i]
			i = 1
			if cb?
				if result = cb permutation[..]
					return result
			else
				result.push permutation[..]
		else
			c[i] = 0
			++i
	result unless cb?

n_of = permute.n_of = ( n, arr, cb, args=[] )->
	if n<1
		return cb []
	for el, i in arr
		if n>1
			next = arr[...i].concat arr[i+1..]
			out = n_of n-1, next, cb, args.concat [el]
		else
			out = cb args.concat [el]
		if out
			return out
	return

minmax_of = permute.minmax_of = ( min, max, arr, cb )->
	for i in [min..max]
		if out = n_of i, arr, cb
			return out
	return



# print is deprecated
exports._print = exports.print = _log 
