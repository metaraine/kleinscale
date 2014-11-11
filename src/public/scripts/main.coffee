birthYear = 1985
deathAge = 90
currentYear = (new Date).getFullYear()
currentAge = currentYear - birthYear

data = [
	{
		title: 'Birth'
		age: 0
		value: 100
		description: 'No subject-object division'
	}
	{
		title: 'Started talking'
		age: 2
		value: 97
		description: 'Recognition of objects but no selfconsciousness'
	}
	{
		title: 'Family moved to Vermont'
		age: 4
		value: 95
	}
	{
		title: 'Started kindergarten'
		age: 5
		value: 90
		description: 'First significant exposure to others'
	}
	{
		title: 'Scolded for kicking classmate on swing'
		age: 8
		value: 20
		description: 'I kicked a classmate in a random but innocent outburst. I was scolded harshly and began doubting my basic goodness.'
	}
	{
		title: 'Older students complimented my saxaphone playing'
		age: 10
		value: 25
		description: 'I didn\'t know how to receive a compliment and felt extremely embarrassed, not knowing how to respond.'
	}
	{
		title: 'Danced the Grapevine'
		age: 11
		value: 22
		description: 'I felt intense shame and exposure when my teacher made an innocent comment as I danced the "Grapevine" down the stairs at school. I became very cautious about my behavior at this point.'
	}
	{
		title: 'Was told my eyebrows looked funny'
		age: 14
		value: 30
		description: 'A classmate made fun of my eyebrows and I didn\t know how to respond, internalizing the judgment. I have felt ugly for as long as I can remember.'
	}
	{
		title: 'Sang and played guitar in front of my high school'
		age: 18
		value: 80
		description: 'The small, private high school I moved to senior year offered safe environment and I began to express myself more freely.'
	}
	{
		title: 'Plagued with anxiety during college orientation'
		age: 19
		value: 20
		description: 'My undergraduate education was a painful time for me as my embarrassment and anxiety resurfaced amidst the chaotic and competitive social atmosphere. I became seriously depressed.'
	}
	{
		title: 'Managed a team of card players'
		age: 24
		value: 65
		description: 'I found satisfaction and confidence in managing and supporting a team of amateur card players.'
	}
	{
		title: 'Discovered love of teaching'
		age: 26
		value: 75
		description: 'I felt new personal strengths rise to the surface when I was given the opportunity to teach web development at the company I was at.'
	}
	{
		title: 'Celebrated coffee house at end of Maitri I'
		age: 29
		value: 80
		description: 'Surrounded by my new "family", I felt a level of relaxation and unconditional appreciation for those around me in a way I hadn\'t in a long time.'
	}
	{
		title: 'Interned at Mental Health Partners'
		age: 31
		value: 45
		description: 'I found myself intensely challenged and flummoxed in applying everything I had learned personally and at Naropa in a real-world situation.'
	}
	{
		title: 'Traveled through India and Southeast Asia'
		age: 39
		value: 66
		description: 'After working as a bilingual group therapist in Boulder for several years, I felt ready for my longtime dream of traveling through Asia, visiting sacred Buddhist sites.'
	}
	{
		title: 'Met lifelong partner'
		age: 42
		value: 90
		description: 'I fell in love with a somatic therapist from San Francisco who I met on my travels in Asia.'
	}
	{
		title: '3-year Retreat'
		age: 45
		value: 97
		description: 'After 20 years of meditation practice I was prepared to do my 3-year retreat.'
	}
	{
		title: 'Facilitated first workshop at the Contemplative Life Institute'
		age: 48
		value: 85
		description: 'I was thrilled to accept a faculty position at the Contemplative Life Institute where I could finally bring my group facilitation experience and my passion for contemplative practice together.'
	}
	{
		title: 'Became Director of the Contemplative Life Institute'
		age: 50
		value: 81
		description: 'I felt closer to my calling than ever before as I humbly stepped into the lead role at the Institute.'
	}
	{
		title: 'Launched the Contemplative Life Institute\'s first Summer of Self-Discovery'
		age: 54
		value: 93
		description: 'I felt an ease and confidence like never before as I initiated a new program that was practically an extension of myself.'
	}
	{
		title: 'Meltdown at international peacekeeping conference'
		age: 56
		value: 48
		description: 'Relationship challenges and work exhaustion took a toll and I experienced a severe emotional breakdown that would lead to two years of depression.'
	}
	{
		title: 'Discriminated against because of my age'
		age: 62
		value: 60
		description: 'I experienced the sad reality of living in an oppressive society, that would at times trump even my extensive personal, interpersonal, and spiritual work.'
	}
	{
		title: 'First published book receives harsh criticism'
		age: 65
		value: 65
		description: 'My book received widespread criticism for its unorthodox stance against the Digital Lifestyle.'
	}
	{
		title: 'Self-identity challenged with first major physical disability'
		age: 70
		value: 87
		description: 'A hip injury put me in a wheelchair, challenging my long identity as able-bodied.'
	}
	{
		title: 'Celebrated 40-year anniversary with partner'
		age: 82
		value: 92,
		description: 'I felt immense gratitude and knew that I wouldn\'t be the same without this person.'
	}
	{
		title: 'Stroke eliminated higher cognitive functioning'
		age: 88
		value: 99
		description: 'I resorted to a state of unresponsiveness, requiring 24/7 care.'
	}
	{
		title: 'Death'
		age: 90
		value: 100
		description: 'The little selfconsciousness I had left dissolved completely as my living incarnation came to an end.'
	}
]

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

# initialize chart
new Morris.Line
	element: 'chart'
	data: data
		.map mapOverKey _.partial(add, birthYear), 'age', 'year'
		.map mapOverKey intoString, 'year'
	events: [currentYear.toString()]
	eventLineColors: ['lightgray']
	xkey: 'year'
	ykeys: ['value']
	labels: ['Unselfconsciousness']
	lineColors: ['#2ecc71']
	smooth: false
	postUnits: '%'
	resize: true
	hideHover: true
	xLabelFormat: (date)->
		date.getFullYear() - birthYear
	hoverCallback: (index, options, content, row)->
		templateHoverLabel row

# set x-position of .present dynamically based on current year
$('.present').css 'left', (currentAge/deathAge*100 + 1) + '%'
