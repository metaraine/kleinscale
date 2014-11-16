# constants for klein data processing
letters = 'abcdefg'
colors = ['rgb(122, 146, 163)', 'rgb(11, 98, 164)', 'rgb(77, 167, 77)']
times = ['past', 'present', 'ideal']

xLabelsAtoE = ['Other Sex Only', 'Other Sex Mostly', 'Other Sex Somewhat More', 'Both Sexes Equally', 'Same Sex Somewhat More', 'Same Sex Mostly', 'Same Sex Only']

xLabelsFtoG = ['Hetero Only', 'Hetero Mostly', 'Hetero Somewhat More', 'Hetero/Gay or Lesbian Equally', 'Gay or Lesbian Somewhat More', 'Gay or Lesbian Mostly', 'Gay or Lesbian Only']

kleinVariables =
	a: 'Sexual Attraction'
	b: 'Sexual Behavior'
	c: 'Sexual Fantasies'
	d: 'Emotional Preferences'
	e: 'Social Preferences'
	f: 'Hetero or Homo Lifestyle'
	g: 'Self Identification'

# parse and compile all Handlebars templates into a more convenient object
compileTemplates = ()->
	cint.toObject $('.template'), (el)->
		templateFunction = Handlebars.compile($(el).html())
		# key: name of the template
		# value: templating function
		cint.keyValue($(el).attr('data-template-name'), templateFunction)

# process kleinData of a single data point (attraction, behavior, etc) into Morris format
processKleinData = (kleinDataObjects)->

	# convert the klein data into a tallied data structure
	talliedAData = cint.tallyProps(kleinDataObjects)

	# flatten the tallied data into an array of objects, one level deep to be usable by morris
	cint.toArray talliedAData, (key, value)->
		_.extend({klein:key}, value)

createMorrisChart = (el, morrisData)->

	new Morris.Bar
		element: el
		data: morrisData
		xkey: 'klein'
		ykeys: times
		labels: times.map(cint.toTitleCase)
		barColors: colors
		smooth: false
		resize: true
		hideHover: true
		# xLabelFormat: (date)->
			# date.getFullYear() - birthYear
		# hoverCallback: (index, options, content, row)->
			# templateHoverLabel row

# templates out a chart with the given templating function and template data, then renders it in the given parent with the given morris data
renderChart = (parent, templateFunction, templateData, morrisData)->

	# generate the chart container from the template
	chart = $('<div>')
		.addClass('chart')
		.appendTo(parent)
		.html(templateFunction(templateData))

	# render the chart using morris
	createMorrisChart $('.chart-container', chart), morrisData

	chart

init = ()->

	# compile all templates on the page
	templates = compileTemplates()

	for letter,kleinVariableLabel of kleinVariables

		# process the klein data from the server
		morrisData = processKleinData(_.pluck(kleinData, letter))

		# get the keys of the morrisData to determine the x-axis labels
		xLabelSet = if letter in 'abcde' then xLabelsAtoE else xLabelsFtoG
		xLabels = _.pluck(morrisData, 'klein')
			.map((n)->n-1)
			.map(cint.index.bind(null, xLabelSet))

		# data for the handlebars chartTemplate
		templateData =
			title: kleinVariableLabel
			yLabel: '# of Respondents'
			xLabel: 'Klein Scale'
			subXLabels: xLabels.map (label, i)->
				label: label
				width: 100/xLabels.length # evenly space them along the x-axis

		# render the chart
		renderChart('.charts', templates.chartTemplate, templateData, morrisData)


init()
