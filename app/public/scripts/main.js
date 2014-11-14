(function() {
  var add, addTwo, intoString, mapOverKey, morrisData, setValue, spy, tap, templateHoverLabel;

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

  morrisData = kleinData.map(function(kleinPerson) {
    return {
      klein: kleinPerson.a,
      past: kleinPerson.a.past,
      present: kleinPerson.a.present,
      ideal: kleinPerson.a.ideal
    };
  });

  new Morris.Bar({
    element: 'chart',
    data: morrisData,
    xkey: 'klein',
    ykeys: ['past', 'present', 'ideal'],
    labels: ['Past', 'Present', 'Ideal'],
    lineColors: ['#2ecc71'],
    smooth: false,
    resize: true,
    hideHover: true
  });

}).call(this);
