GoogleSpreadsheet = require("google-spreadsheet")
sheet = new GoogleSpreadsheet('1hatq6HbLUix4ATO6A2-Q9PyYCjCqigRG919w0ijQqR4')

module.exports =
	index: (req, res)->

		sheet.getRows 1, (err, rows)->
			if(err) then console.log(err); return

			data = {}
			letters = 'abcdefg'
			times = ['past', 'present', 'ideal']

			# loop through every combination of a.past, a.present, a.ideal, b.past, etc
			# and create a more sensible nested data structure
			for row in rows
				for letter in letters
					data[letter] = {}
					for time in times
						data[letter][time] = +row[letter + '.' + time]

			res.render 'index', kleinData: data
