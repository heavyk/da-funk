
# reminder: we really should remove lodash, as the whole point of this is to make things smaller anyway ..
# focus on function, instead of package or even module. framework is deadly programmer poison.. it might have happened to me once before..
_ = require \lodash
Path = require \path

parse-function-basic = (fn) ->
	fn-txt = if typeof fn is \string => fn else fn.to-string!trim!
	i = fn-txt.index-of '('
	ii = fn-txt.index-of ')'
	iii = fn-txt.index-of 'function'
	j = fn-txt.index-of '{'
	jj = fn-txt.last-index-of '}'
	name = fn-txt.substring iii, i .trim!
	args = fn-txt.substring ++i, ii .replace (new RegExp ' ', \g), ''
	body = fn-txt.substring ++j, jj .trim!
	return { name, args, body, is-generator: ~fn-txt.substring iii, j .index-of \* }

#TODO: if typeof obj is \object then this function, else use JSON.stringify
regex_slash = new RegExp '\\\\', \g
regex_quote = new RegExp '"', \g
regex_newline = new RegExp '\n', \g
regex_tab = new RegExp '\t', \g
regex_tabspace = new RegExp '\t  ', \g
regex_space = new RegExp ' ', \g
regex_newspace = for i to 10 => new RegExp '\n'+(' '*i), 'g'
regex_newline = regex_newspace.0
_iindent = for i to 4 => '\t' * i # preload up to 4 indent levels
clean_str = (str) ->
	"use strict"
	(str+'').replace regex_slash, '\\\\' .replace regex_quote, '\\"' .replace regex_newline, '\\n' .replace regex_tab, '\\t'

interjection = (fn, obj, desired_order = [], indent = 1) ->
	unless iindent = _iindent[indent]
		iindent = _iindent[indent] = '\t' * indent
	out = []

	_fn = if typeof fn is \function => fn.toString!
	else if typeof fn is \string => fn
	else (->).toString!
	i = _fn.indexOf '('
	ii = _fn.indexOf ')'
	j = _fn.indexOf '{'
	jj = _fn.lastIndexOf '}'
	_fn_name = _fn.substring 'function'.length, i
	_fn_args = _fn.substring(++i, ii).replace(regex_space, '')
	_fn_body = _fn.substring(++j, jj).trim!
	if ~(i = _fn.indexOf '\n')
		ii = i + 1
		while _fn[ii] is ' ' => ii++
		unless regex_newspace[iii = ii - i + 1 - 2]
			regex_newspace[iii] = new RegExp '\n'+(' '*iii), 'g'
		_fn_body = _fn_body.replace regex_newspace[ii - i + 1 - 2], '\n\t'
		do
			len = _fn_body.length
			_fn_body = _fn_body.replace regex_tabspace, '\t\t' # _iindent[2]
		while _fn_body.length isnt len
	_fn_body = '\n\t'+(_fn_body)+'\n' if _fn_body.length

	# sort our keys alphabetically
	k = Object.keys obj .sort!
	# then, desired order keys get plaed on top in reverse order
	if (doi = desired_order.length-1) >= 0
		do
			if ~(i = k.indexOf desired_order[doi])
				kk = k.splice i, 1
				k.unshift kk.0
		while --doi >= 0

	if k.length
		for key in k
			if (o = obj[key]) is null
				out.push key+' = null'
			else switch typeof o
			| \function =>
				_fn = o.toString!
				i = _fn.indexOf '('
				ii = _fn.indexOf ')'
				j = _fn.indexOf '{'
				jj = _fn.lastIndexOf '}'
				name = _fn.substring 'function'.length, i
				args = _fn.substring(++i, ii).replace(regex_space, '')
				body = _fn.substring(++j, jj).trim!
				# console.log "#k:args:", args
				# console.log "#k:body:", body
				# console.log "#k:orig:", _fn
				_fn_indent = _iindent[indent+1]
				if ~(i = _fn.indexOf '\n')
					ii = i + 1
					while _fn[ii] is ' ' => ii++
					unless regex_newspace[iii = ii - i + 1 - 2]
						regex_newspace[iii] = new RegExp '\n'+(' '*iii), 'g'
					body = body.replace regex_newspace[ii - i + 1 - 2], '\n'+_fn_indent
					do
						len = body.length
						body = body.replace regex_tabspace, '\t\t'
					while body.length isnt len

				#TODO: if ugly, go ahead and uglify this
				body = '\n'+_fn_indent+(body)+'\n' if body.length
				out.push "#key = function#name(#args){#{body+iindent}}"
			| \string =>
				out.push key+' = "'+clean_str(o)+'"'
			| \number \boolean =>
				out.push key+' = '+o
			| \object =>
				if typeof o.length is \number or _.isArray o
					if o.length
						out.push key+" = [\n#{iindent}\t" + (_.map o, (vv) -> if typeof vv is \object then stringify vv, desired_order, indent+1 else JSON.stringify vv).join(",\n\t#{iindent}") + "\n#{iindent}]"
					else
						out.push key+' = []'
				else if o is null
					out.push key+' = null'
				else
					out.push key+' = '+stringify o, desired_order, indent+1
		return if typeof fn is \string
			"function#{_fn_name}(#{_fn_args}) {\n#{iindent}var "+ out.join(",\n#{iindent}")+";\n#{_iindent[indent-1]}#{_fn_body}\n}"
		else
			console.log "new Function" _fn_args, _fn_body
			new Function _fn_args, _fn_body
	else if indent is 1 then "{}\n" else "{}"




stringify = (obj, desired_order = [], indent = 1) ->
	out = []
	# technically, this should scale up perfectly, so there should be no holes in the array
	# assert i > 0
	unless iindent = _iindent[indent]
		iindent = _iindent[indent] = '\t' * indent

	# sort our keys alphabetically
	k = Object.keys obj .sort!
	# then, desired order keys get plaed on top in reverse order
	if (doi = desired_order.length-1) >= 0
		do
			if ~(i = k.indexOf desired_order[doi])
				kk = k.splice i, 1
				k.unshift kk.0
		while --doi >= 0

	if k.length
		for key in k
			if (o = obj[key]) is null
				out.push '"'+key+'": null'
			else switch typeof o
			| \function =>
				out.push '"'+key+'": 8'
				o = o.toString!
				key += '.js'
				if typeof obj[key] is \undefined
					_fn = o.toString!
					i = _fn.indexOf '('
					ii = _fn.indexOf ')'
					j = _fn.indexOf '{'
					jj = _fn.lastIndexOf '}'
					args = _fn.substring(++i, ii).replace(regex_space, '')
					body = _fn.substring(++j, jj).trim!
					# console.log "#k:args:", args
					# console.log "#k:body:", body
					# console.log "#k:orig:", _fn
					if ~(i = _fn.indexOf '\n')
						ii = i + 1
						while _fn[ii] is ' ' => ii++
						unless regex_newspace[iii = ii - i + 1 - 2]
							regex_newspace[iii] = new RegExp '\n'+(' '*iii), 'g'
						body = body.replace regex_newspace[ii - i + 1 - 2], '\n\t'
						do
							len = body.length
							body = body.replace regex_tabspace, '\t\t' # _iindent[2]
						while body.length isnt len

					#TODO: if ugly, go ahead and uglify this
					body = '\\n\\t'+clean_str(body)+'\\n' if body.length
					out.push '"'+key+'": "function('+args+'){'+body+'}"'
			| \string =>
				out.push '"'+key+'": "'+clean_str(o)+'"'
			| \number \boolean =>
				out.push '"'+key+'": '+o
			| \object =>
				if typeof o.length is \number or _.isArray o
					if o.length
						out.push '"'+key+"\": [\n#{iindent}\t" + (_.map o, (vv) -> if typeof vv is \object then stringify vv, desired_order, indent+1 else JSON.stringify vv).join(",\n\t#{iindent}") + "\n#{iindent}]"
					else
						out.push '"'+key+'": []'
				else if o is null
					out.push '"'+key+'": null'
				else
					out.push '"'+key+'": '+stringify o, desired_order, indent+1
		return "{\n#{iindent}"+ out.join(",\n#{iindent}")+"\n#{_iindent[indent-1]}}#{if indent is 1 => '\n' else ''}"
	else if indent is 1 then "{}\n" else "{}"

da_funk_scopes = []
da_funk_callthrough = []
empty_scope = {}
da_funk_callthrough.i = 0

# horray for freedom functions, lol
# soon they won't be able to be evil or eval. instead, they'll be evel... :)
# everyone has the right to basic funk freedom - but don't be eval
freedom = (obj, scope, refs) ->
	return {} if typeof obj isnt \object
	refs = if typeof refs isnt \object => {} else _.cloneDeep refs
	# unless refs.name
	# 	debugger
	basename = refs.name or ''
	basepath = refs.path
	if typeof refs.__i is \undefined
		refs.__i = 0
	# else if refs.__i++ > (refs.deep || 10)
	# 	throw new Error "too deep"
	# 	return

	if typeof scope isnt \object or not scope
		scope = {} #empty_scope
	# console.error "da_funk", scope


	# !some! this is obsolete. see duralog's work on evel:
	# natevw/evel#20 and natevw/evel#21
	# soon, it'll integrate to provide a secure environment for execution
	# OPTIMIZE: maybe we could cut down on the function signature doing all the parsing in a different function..
	f = new Function """
		var scope = this;
		if((typeof window !== 'object' || this !== window) && (typeof global !== 'object' || this !== global)) {
			for (var i in this) {
				eval(i+' = this[i];');
			}
		}
		return function(name, refs, obj) {
			var _fn, _fn_txt;
			var f = function() {
				try {
					if(typeof (_fn_txt = obj[name+'.js']) === 'string') {
						//console.log("generating function...", name);
						var i = _fn_txt.indexOf('(');
						var ii = _fn_txt.indexOf(')');
						var j = _fn_txt.indexOf('{');
						var jj = _fn_txt.lastIndexOf('}');
						var args = _fn_txt.substring(++i, ii).replace(new RegExp(' ', 'g'), '');
						var body = '"use strict"\\n"' + refs.name + '"\\n' + _fn_txt.substring(++j, jj).trim();
						_fn = new Function(args, body);
						delete obj[name+'.js'];
					}
					return _fn.apply(this, arguments);
				} catch(e) {
					console.log(e.stack)
					var s = (e.stack+'').split('\\n')
					if(_fn) {
						var line, _fn_s = _fn.toString().split('\\n');
						line = (/\\:([0-9]+)\\:([0-9]+)\\)$/.exec(s[1]));
						line = line ? line[1] * 1 : 'unknown';
						var sp = "          ".substr(2, (_fn_s.length+'').length);
						var block = []
						_fn_s.map(function(s, i) {
							i++;
							if(line < (i+3) && line > (i-3)) block.push((i++)+":"+sp+s)
						}).join('\\n')
						console.error(s[0]+"\\n("+refs.name+" line: "+line+")\\n"+block.join('\\n'))
						//throw e;
					} else {
						console.error("function was not able to be found", refs)
						throw e;
					}
				}
			}
			return f
		}
		"""
	callthrough = f.call scope
	da_funk_scopes.push obj
	for k in (keys = Object.keys obj)
		v = obj[k]
		# I choose 8 because it's unlikely that an unintended value will be of value '8'
		# it takes up only one byte, and it looks like infinaty
		# it could be any number though...
		# OPTIMIZE: this might be able to be improvesd further by making this a getter, then overwrite the getter when setting it to callthrough
		if v is 8 and typeof (_fn = obj[k+'.js']) is \string
			# i = _fn.indexOf '('
			# ii = _fn.indexOf ')'
			# j = _fn.indexOf '{'
			# jj = _fn.lastIndexOf '}'
			refs.path = if basepath => basepath+'.'+k else k
			refs.name = basename+'.'+k
			# args = _fn.substring(++i, ii).replace(regex_space, '')
			# body = '"use strict"\n"' + basename + '"\n' + _fn.substring(++j, jj).trim!
			# console.log ":args:", args
			# console.log ":body:", body
			# console.log ":orig:", _fn
			# console.log "'#body'"
			delete obj[k+'.js']
			Object.defineProperty obj, k+'.js', enumerable: false, value: _fn
			obj[k] = callthrough(k, refs, obj)
		else if v and typeof v is \object and v isnt obj and refs.__i <= (refs.deep || 4) and v.__proto__ is ({}).__proto__
			refs.path = if basepath => basepath+'.'+k else k
			refs.name = basename+'.'+k
			# console.log "k:", k, obj[k], v.__proto__ is Object
			++refs.__i
			freedom obj[k], scope, refs
			--refs.__i
	obj

objection = (object, scope, refs) ->
	if typeof str is \string
		try
			str = JSON.parse
	# refs = {} if typeof refs isnt \object
	# if str.0 is '/' or (str.0 is '.' and str.1)
	# 	str = ToolShed.readFile str

	freedom if typeof str is \string => JSON.parse str else str, scope, refs


merge = (a, b) ->
	keys = _.union Object.keys(a), Object.keys(b)
	for k in keys
		if b.hasOwnProperty k# and k.0 isnt '_'
			v = b[k]
			c = a[k]

			a[k] = \
			if _.isArray c
				if _.isArray v
					_.union v, c
				else if typeof v isnt \undefined
					c ++ v
				else c
			else if _.isObject(v) and _.isObject(c)
				merge c, v
			else if typeof c is \undefined => v
			else c
	return a

improves = (a, b) ->
	# c = {}
	# keys = _.union Object.keys(a), Object.keys(b)
	if typeof b is \object or typeof b is \function
		keys = Object.keys(b)
		for k in keys
			_b = b[k]
			_a = a[k]
			console.log "k:", k
			if b.hasOwnProperty k and k.0 isnt '_'
				_k = k
				a[k] = \
				if _a isnt _b and typeof _b is \object and typeof _a is \object
					improves(improves({}, _a), _b)
				else _b || _a
	return a


extend = (a, b) ->
	if typeof b is \object or typeof b is \function
		keys = Object.keys(b)
		for k in keys
			if b.hasOwnProperty k and k.0 isnt '_'
				_k = k
				_a = a[k]
				is_and = false
				if (k.indexOf 'also|') is 0
					is_and = true
					_b = b[_k]
					k = k.substr "also|".length
					_a = a[k]
				else
					is_and = true if k is \initialize
					_b = b[k]
				a[k] = \
				if is_and and (typeof _a is \function or (is_and and if typeof a[_k] is \function => _a = a[_k])) and (typeof _b is \function)
					if isArray = _.isArray _a.___fnArray
						_a.___fnArray.push _b
						_a
					else
						__fn = -> for _fn in __fn.___fnArray => _fn.apply this, &
						__fn.___fnArray = [_a, _b]
						__fn
				else if _.isArray _a
					if _.isArray _b
						_.union _b, _a
					else if typeof _b isnt \undefined
						_a ++ _b
					else _a
				# else if _a isnt _b and _.isObject(_b) and _.isObject(_a)
				else if _a isnt _b and typeof _b is \object and typeof _a is \object
					extend(extend({}, _a), _b)
				# else if typeof _b is \undefined => _a else _b
				# else
				# 	if typeof _b is \object
				else _b || _a
	return a

# gatta give a shout out to bootsie for his basic funk formula
# yt: IHE6hZU72A4, 2Sh9cezHNec
formula = (a, b) ->


embody = (obj) ->
	deps = {}
	i = &.length
	while i-- > 1
		if _.isObject a = &[i]
			deps = extend deps, a
	merge obj, deps

stringify.desired_order = (path) ->
	# TODO: add more cases for common config fles (bower, browserify, etc.)
	# TODO: add higher-depth object ordering as well. ex:
	# desired_order.subpaths.'sencillo' = <[universe creator]>
	# desired_order.subpaths.'a.long.subpath' = <[a good ordering]>
	switch Path.basename path
	| \component.json \package.json =>
		<[name version description homepage author contributors maintainers repo dependencies]>
	| otherwise => []

# TODO: export stuff here with interfaces compatible with TypeScript

export parse-function-basic
export stringify
export freedom
export interjection
export objection
export merge
export extend
export improves
export embody
