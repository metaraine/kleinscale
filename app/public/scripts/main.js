(function() {
  var aData, add, addTwo, chart, chartHtml, intoString, letters, mapOverKey, morrisData, roundObjectProperties, roundValue, setValue, spy, talliedAData, tap, templates, times;

  addTwo = function(x, y) {
    return x + y;
  };

  add = function() {
    return [].reduce.call(arguments, addTwo);
  };

  intoString = function(value) {
    return value.toString();
  };

  setValue = function(o, key, value) {
    var newObject;
    newObject = _.clone(o);
    newObject[key] = value;
    return newObject;
  };

  mapOverKey = function(f, originalKey, newKey) {
    return function(o) {
      return setValue(o, newKey || originalKey, f(o[originalKey]));
    };
  };

  tap = function(f, o) {
    f(o);
    return o;
  };

  spy = _.partial(tap, console.log.bind(console));

  templates = cint.toObject($('.template'), function(el) {
    var templateFunction;
    templateFunction = Handlebars.compile($(el).html());
    return cint.keyValue($(el).attr('data-template-name'), templateFunction);
  });


  /* Example kleinPerson
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
   */

  letters = 'abcdefg';

  times = ['past', 'present', 'ideal'];

  roundValue = function(key, value) {
    return cint.keyValue(key, Math.round(value));
  };

  roundObjectProperties = _.partial(cint.mapObject, _, roundValue);

  aData = _.pluck(kleinData, 'a').map(roundObjectProperties);

  talliedAData = cint.tallyProps(aData);

  morrisData = cint.toArray(talliedAData, function(key, value) {
    return _.extend({
      klein: key
    }, value);
  });

  chartHtml = templates.chartTemplate({
    title: 'Sexual Attraction',
    yLabel: 'Respondants',
    xLabel: 'Klein Scale',
    xLeftSubLabel: 'Heterosexual',
    xRightSubLabel: 'Homosexual'
  });

  chart = $('<div>').appendTo('.charts').html(chartHtml);

  new Morris.Bar({
    element: $('.chart-container', chart),
    data: morrisData,
    xkey: 'klein',
    ykeys: times,
    labels: times.map(cint.toTitleCase),
    lineColors: ['#2ecc71'],
    smooth: false,
    resize: true,
    hideHover: true
  });

}).call(this);
