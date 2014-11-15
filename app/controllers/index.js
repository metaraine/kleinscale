(function() {
  var GoogleSpreadsheet, sheet;

  GoogleSpreadsheet = require("google-spreadsheet");

  sheet = new GoogleSpreadsheet('1hatq6HbLUix4ATO6A2-Q9PyYCjCqigRG919w0ijQqR4');

  module.exports = {
    index: function(req, res) {
      return sheet.getRows(1, function(err, rows) {
        var allKleinResults, letter, letters, personKleinResults, row, time, times, _i, _j, _k, _len, _len1, _len2, _ref;
        if (err) {
          console.log(err);
          return;
        }
        letters = 'abcdefg';
        times = ['past', 'present', 'ideal'];
        allKleinResults = [];
        _ref = rows.slice(1);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          row = _ref[_i];
          allKleinResults.push(personKleinResults = {});
          for (_j = 0, _len1 = letters.length; _j < _len1; _j++) {
            letter = letters[_j];
            personKleinResults[letter] = {};
            for (_k = 0, _len2 = times.length; _k < _len2; _k++) {
              time = times[_k];
              personKleinResults[letter][time] = +row[letter + '.' + time];
            }
          }
        }
        return res.render('index', {
          kleinData: allKleinResults
        });
      });
    }
  };

}).call(this);
