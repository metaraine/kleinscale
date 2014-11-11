(function() {
  var GoogleSpreadsheet, sheet;

  GoogleSpreadsheet = require("google-spreadsheet");

  sheet = new GoogleSpreadsheet('1hatq6HbLUix4ATO6A2-Q9PyYCjCqigRG919w0ijQqR4');

  module.exports = {
    index: function(req, res) {
      return sheet.getRows(1, function(err, rows) {
        var data, letter, letters, row, time, times, _i, _j, _k, _len, _len1, _len2;
        if (err) {
          console.log(err);
          return;
        }
        data = {};
        letters = 'abcdefg';
        times = ['past', 'present', 'ideal'];
        for (_i = 0, _len = rows.length; _i < _len; _i++) {
          row = rows[_i];
          for (_j = 0, _len1 = letters.length; _j < _len1; _j++) {
            letter = letters[_j];
            data[letter] = {};
            for (_k = 0, _len2 = times.length; _k < _len2; _k++) {
              time = times[_k];
              data[letter][time] = +row[letter + '.' + time];
            }
          }
        }
        return res.render('index', {
          kleinData: data
        });
      });
    }
  };

}).call(this);
