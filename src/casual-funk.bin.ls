
da-funk = require \..

/*
```js
function rock_it(tempo, bassline, vocoder) {
	'{{FUNK_FORMULA("rock_it", {strict: true, asm: true}) {                                              }}';
	'this.tempo = {                                                                                             ';
	' "-> Number": "is your desired pace for this tune expessed in beats per minute",                       ';
	' "-> Array(Number)": "an array of preference for tempo"                                               ';
	' "-> KeydTransition": "variation of tempo expressed through keyframes as instanceof `KeydTransition`" ';
	'this.bassline ={                                                                                          ';
	' -> [Tune] bassline as instanceof `Tune`                                                           ';
	'return [Tune] greatest hit! your expressed masterpiece                                             ';
	// you can choose for it
}

```
*/


# {{=PACKAGE.name}}

"""
### yep, da funk!

```
 so, 'funk' used to mean something scary...
	... but, back then, we were also scared of dancin'
```

# Express yo-self!

here's how you do it

### API


{{!this.funk}}
{{/}}

	#### {{name}}
	{{explain funk.arguments}}
		{{boogie.name}} - {{boogie.description}}
		{{boogie.breakdown?}}
	{{/}}
{{/}}

### basic breakdown


### you gatta keep it on the ONE

funk does not have its roots in classical music.
you should be jammin' - not of writin a composition
we also think that your tunes should express themselves!

this is how to do it (da-na-na-na-na)

#### rememer to keep it on the one

so, the first line of your function should a plain string,
the same way you'd write `'use strict';` lay down your
>> BASIC FUNK FORMULA <<





### doT-funk



### package.json


### command-line interface (not yet complete)

/I practice readme driven development, so bear with me/

we've provided a program called `lackadaisical-funk`

however, if you can never rememer how to spell such a
 ... complicated ... word, (it means laid-back or lazy)
			word, instead -- be cool; use `lack-a-daisy-go-funk`

if you're a serious person using this new means of
	expressing your software's function, there's

								`casual-funk`

we assure you that the other ones are more fun, but
	befor we do that, we should break it down for ya

ok, so let's get started:

`$ casual-funk analyze`

will analyze current working directory for js files and also
 look downward for a `package.json` it

next, it will allow you to begin documenting those functions
just select a function with the arrow keys and it will ask you
once for your editor (default: `process.env.EDITOR`)


"""

$package = require '../package.json'
doT = require \dot

doT-funk-formula = {
	evaluate:     /\{\{([\s\S]+?)\}\}/g
	interpolate:  /\{\{=([\s\S]+?)\}\}/g
	encode:       /\{\{!([\s\S]+?)\}\}/g
	use:          /\{\{#([\s\S]+?)\}\}/g
	define:       /\{\{##\s*([\w\.$]+)\s*(\:|=)([\s\S]+?)#\}\}/g
	conditional:  /\{\{\?(\?)?\s*([\s\S]*?)\s*\}\}/g
	iterate:      /\{\{~\s*(?:\}\}|([\s\S]+?)\s*\:\s*([\w$]+)\s*(?:\:\s*([\w$]+))?\s*\}\})/g
	varname:      'da'
	strip:         false
	append:        true
	selfcontained: false
}
# for key, value of $package.'da-funk'.'doT-funk'
# 	doT-funk-formula[key] = if typeof value is \string and value.0 is '/'
# 		new RegExp value, 'g'
# 	else value

# doT.templateSettings = doT-funk

da-funk-definition = """
some text!
{{\#\#def.rock_it:
	{{!it}}
	lala:...
\#}}


{{
	console.log(JSON.stringify(da));
}}

{{this.funk('rock_it_part_2'); }}

{{!$package.name}} - v{{!$package.version}}

last test

{{!da.funk_count}}

"""

da-funk-expressions = do ->
	@$package = $package
	@funk_count = 0
	@'funk-formula' = "THIS IS THE FORMULA!"
	da = this
	da.groovy = {
		# funk:~->
	}
	da.groove
	da.funk = (name, opts = {}) !->
		@funk_count++
		@name = "lalala"
		@it = "lala"
		return @receives = ->
			$input =
				isAn:
					any:~ -> joi.any!
					object:~ -> joi.object!
				isA:
					boolean:~ -> joi.boolean!
					number:~ -> joi.number!
					string:~ -> joi.string!
					date:~ -> joi.date!
					func:~ -> joi.func!
					binary:~ -> joi.binary!
					ref:~ -> joi.ref!
				alternatively:~ -> joi.alternatives!
			return $input

	@toString = ~>
		"funk it out loud! "+@funk_count
	return this

# .description("this function whips out a sweet retro groove in no time at all")
#  .argument('tempo')
#         .isA
#         	number()
#         	.min(40)
#         	.max(300)
#         	.description("is your desired pace for this tune to be expessed, in beats per minute")
#         .is();

# console.log doT.template.toString! #, da-funk-definition, doT-funk-formula, da-funk-expressions
# return
da-funk-output-path = require \path .join(__dirname, '..', 'FUNK_FORMULA.md')
try
	da-funk-template = doT.template da-funk-definition, doT-funk-formula, da-funk-expressions
	# console.log da-funk-template.toString!
catch e
	# require \fs .writeFileSync da-funk-output-path, "#{e.stack}\n\n\n#{e.message}"
	require \fs .writeFileSync da-funk-output-path, "#{e.message}"
	console.log "error:", e.stack
	return
try
	da-funk-output = da-funk-template da-funk-expressions
	console.log "writing #{da-funk-output.length} bytes to #{da-funk-output-path}"
	require \fs .writeFileSync da-funk-output-path, "#{da-funk-output}\n\n\n#{da-funk-template.toString!replace /\;/g, ';\n'}"
catch e
	# require \fs .writeFileSync da-funk-output-path, "#{e.stack}\n\n\n#{e.message}"
	require \fs .writeFileSync da-funk-output-path, "#{e.stack}\n\n#{da-funk-template.toString!}"


return
