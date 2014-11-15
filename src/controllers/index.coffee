GoogleSpreadsheet = require("google-spreadsheet")
sheet = new GoogleSpreadsheet('1hatq6HbLUix4ATO6A2-Q9PyYCjCqigRG919w0ijQqR4')

module.exports =
	index: (req, res)->

		sheet.getRows 1, (err, rows)->
			if(err) then console.log(err); return

			# constants that help expand out all the survey questions
			letters = 'abcdefg'
			times = ['past', 'present', 'ideal']

			# array of klein result objects for each person
			allKleinResults = []

			# loop through every combination of a.past, a.present, a.ideal, b.past, etc
			# and create a more sensible nested data structure
			for row in rows.slice(1) # ignore extra header row
				allKleinResults.push personKleinResults = {}
				for letter in letters
					personKleinResults[letter] = {}
					for time in times
						personKleinResults[letter][time] = +row[letter + '.' + time]

			res.render 'index', kleinData: allKleinResults
