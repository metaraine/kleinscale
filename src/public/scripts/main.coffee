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

templateHoverLabel = Handlebars.compile $('#hover-label').html()

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

# process kleinData into Morris format
morrisData = kleinData.map (kleinPerson)->
	{
		klein: kleinPerson.a,
		past: kleinPerson.a.past,
		present: kleinPerson.a.present,
		ideal: kleinPerson.a.ideal
	}

# initialize chart
new Morris.Bar
	element: 'chart'
	data: morrisData
		# .map mapOverKey _.partial(add, birthYear), 'age', 'year'
		# .map mapOverKey intoString, 'year'
	# events: [currentYear.toString()]
	# eventLineColors: ['lightgray']
	xkey: 'klein'
	ykeys: ['past', 'present', 'ideal']
	labels: ['Past', 'Present', 'Ideal']
	lineColors: ['#2ecc71']
	smooth: false
	# postUnits: '%'
	resize: true
	hideHover: true
	# xLabelFormat: (date)->
		# date.getFullYear() - birthYear
	# hoverCallback: (index, options, content, row)->
		# templateHoverLabel row

