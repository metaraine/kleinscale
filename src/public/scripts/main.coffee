# constants for klein data processing
letters = 'abcdefg'
times = ['past', 'present', 'ideal']
xLabelsAtoE = ['Other Sex Only', 'Other Sex Mostly', 'Other Sex Somewhat More', 'Both Sexes Equally', 'Same Sex Somewhat More', 'Same Sex Mostly', 'Same Sex Only']
xLabelsFtoG = ['Hetero Only', 'Hetero Mostly', 'Hetero Somewhat More', 'Hetero/Gay or Lesbian Equally', 'Gay or Lesbian Somewhat More', 'Gay or Lesbian Mostly', 'Gay or Lesbian Only']

# parse and compile all Handlebars templates into a more convenient object
compileTemplates = ()->
	cint.toObject $('.template'), (el)->
		templateFunction = Handlebars.compile($(el).html())
		# key: name of the template
		# value: templating function
		cint.keyValue($(el).attr('data-template-name'), templateFunction)

# process kleinData into Morris format
processKleinData = (kleinData)->

	# Given a key and value, round the value and return a key:value object pair
	roundValue = (key, value)-> cint.keyValue(key, Math.round(value))

	# Round all of the klein values
	roundObjectProperties = _.partial(cint.mapObject, _, roundValue)

	aData = _.pluck(kleinData, 'a')
		.map(roundObjectProperties)

	# convert the klein data into a tallied data structure
	talliedAData = cint.tallyProps(aData)

	# flatten the tallied data into an array of objects, one level deep to be usable by morris
	cint.toArray talliedAData, (key, value)->
		_.extend({klein:key}, value)

renderChart = (el, morrisData)->

	new Morris.Bar
		element: el
		data: morrisData
		xkey: 'klein'
		ykeys: times
		labels: times.map(cint.toTitleCase)
		barColors: ['rgb(122, 146, 163)', 'rgb(11, 98, 164)', 'rgb(77, 167, 77)']
		smooth: false
		resize: true
		hideHover: true
		# xLabelFormat: (date)->
			# date.getFullYear() - birthYear
		# hoverCallback: (index, options, content, row)->
			# templateHoverLabel row

init = ()->

	# compile all templates on the page
	templates = compileTemplates()

	# process the klein data from the server
	morrisData = processKleinData(kleinData)

	# generate the chart container from the template
	chart = $('<div>')
		.appendTo('.charts')
		.html templates.chartTemplate
			title: 'Sexual Attraction'
			yLabel: 'Respondants'
			xLabel: 'Klein Scale'
			subXLabels: xLabelsAtoE.map (label, i)->
				label: label
				width: 100/xLabelsAtoE.length

	# render the chart using morris
	renderChart $('.chart-container', chart), morrisData

init()
