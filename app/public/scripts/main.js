(function() {
  var aData, add, addTwo, intoString, letters, mapOverKey, morrisData, roundObjectProperties, roundValue, setValue, spy, talliedAData, tap, templateHoverLabel, times;

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

  templateHoverLabel = Handlebars.compile($('#hover-label').html());


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

  console.log(morrisData);

  new Morris.Bar({
    element: 'chart',
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
