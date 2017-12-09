_log = require 'ololog'
crypto = require 'crypto'


class Generator
	constructor: ( @salt, @hard = 0 )->
		@hs = []
		@cache = []
		@i = 0
		@keys = []
		return

	generate_keys: ( num )->
		while @keys.length < num
			h = @_pop_cand()
			if @_verify h
				@keys.push h
		@keys

	_pop_cand: ->
		if @cache.length
			return @cache.shift()
		else
			while yes
				h = @_next_hash()
				if h.t?
					return h
		_log 'oops'
		return

	_verify: ( h )->
		lim = h.i+1000
		for hh in @cache
			if hh.ps[h.t] and hh.i <= lim
				_log h.i, 'verified by', hh.i
				return yes
		while @i < lim
			hh = @_next_hash()
			if hh.t?
				@cache.push hh
			if hh.ps[h.t]
				_log h.i, 'verified by', hh.i
				return yes
		no

	_next_hash: ->
		i = @i++
		h = @salt + i
		for [0..@hard]
			h = crypto.createHash('md5').update(h).digest 'hex'

		# analyze
		t = undefined
		ps = {}
		n = 0
		prev = undefined
		for c in h
			if c is prev
				++n
				if n is 3
					t ?= c
				if n is 5
					ps[c] = yes
			else
				prev = c
				n = 1
		{i,t,ps,h}


do ->
	try
		salt = 'ahsbgdzn'
		gen = new Generator salt
		gen.generate_keys 64
		_log.yellow gen.keys[63].i

		gen = new Generator salt, 2016
		gen.generate_keys 64
		_log.yellow gen.keys[63].i

	catch e
		_log.red e
	return
