# Adds two numbers together
addTwo = (x,y)-> x + y

# Adds the given arguments together
add = ()->
	[].reduce.call arguments,addTwo

# Converts the given to a string by calling its toString method
intoString = (value)-> value.toString()

# Creates a clone of the given object with the given key set to a new value
setValue = (o, key, value)->
	newObject = _.clone o
	newObject[key] = value
	newObject

# Creates a mapping function that applies the given function to the value of the specific key when mapping over objects
mapOverKey = (f, originalKey, newKey)->
	(o)->
		setValue(o, newKey or originalKey, f(o[originalKey]))

# Invokes a function on an object and returns the object (for chaining purposes)
tap = (f, o)->
	f(o)
	o

# console.log's the given object and returns the object (for chaining purposes)
spy = _.partial tap, console.log.bind(console)

# parse and compile all Handlebars templates into a more convenient object
templates = cint.toObject $('.template'), (el)->
	templateFunction = Handlebars.compile($(el).html())
	# key: name of the template
	# value: templating function
	cint.keyValue($(el).attr('data-template-name'), templateFunction)

### Example kleinPerson
{
	a: {
		ideal: 2,
		past: 2,
		present: 2
	},
	b: {
		ideal: 2,
		past: 2,
		present: 2
	}
}
###

letters = 'abcdefg'
times = ['past', 'present', 'ideal']

# process kleinData into Morris format
roundValue = (key, value)-> cint.keyValue(key, Math.round(value))
roundObjectProperties = _.partial(cint.mapObject, _, roundValue)

aData = _.pluck(kleinData, 'a')
	.map(roundObjectProperties)

talliedAData = cint.tallyProps(aData)
morrisData = cint.toArray talliedAData, (key, value)->
	_.extend({klein:key}, value)

chartHtml = templates.chartTemplate
	title: 'Sexual Attraction'
	yLabel: 'Respondants'
	xLabel: 'Klein Scale'
	xLeftSubLabel: 'Heterosexual'
	xRightSubLabel: 'Homosexual'

chart = $('<div>')
	.appendTo('.charts')
	.html(chartHtml)

# initialize chart
new Morris.Bar
	element: $('.chart-container', chart)
	data: morrisData
	xkey: 'klein'
	ykeys: times
	labels: times.map(cint.toTitleCase)
	lineColors: ['#2ecc71']
	smooth: false
	resize: true
	hideHover: true
	# xLabelFormat: (date)->
		# date.getFullYear() - birthYear
	# hoverCallback: (index, options, content, row)->
		# templateHoverLabel row
