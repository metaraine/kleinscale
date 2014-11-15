(function() {
  var compileTemplates, init, letters, processKleinData, renderChart, times;

  letters = 'abcdefg';

  times = ['past', 'present', 'ideal'];

  compileTemplates = function() {
    return cint.toObject($('.template'), function(el) {
      var templateFunction;
      templateFunction = Handlebars.compile($(el).html());
      return cint.keyValue($(el).attr('data-template-name'), templateFunction);
    });
  };

  processKleinData = function(kleinData) {
    var aData, roundObjectProperties, roundValue, talliedAData;
    roundValue = function(key, value) {
      return cint.keyValue(key, Math.round(value));
    };
    roundObjectProperties = _.partial(cint.mapObject, _, roundValue);
    aData = _.pluck(kleinData, 'a').map(roundObjectProperties);
    talliedAData = cint.tallyProps(aData);
    return cint.toArray(talliedAData, function(key, value) {
      return _.extend({
        klein: key
      }, value);
    });
  };

  renderChart = function(el, morrisData) {
    return new Morris.Bar({
      element: el,
      data: morrisData,
      xkey: 'klein',
      ykeys: times,
      labels: times.map(cint.toTitleCase),
      lineColors: ['#2ecc71'],
      smooth: false,
      resize: true,
      hideHover: true
    });
  };

  init = function() {
    var chart, morrisData, templates;
    templates = compileTemplates();
    morrisData = processKleinData(kleinData);
    chart = $('<div>').appendTo('.charts').html(templates.chartTemplate({
      title: 'Sexual Attraction',
      yLabel: 'Respondants',
      xLabel: 'Klein Scale',
      xLeftSubLabel: 'Heterosexual',
      xRightSubLabel: 'Homosexual'
    }));
    return renderChart($('.chart-container', chart), morrisData);
  };

  init();

}).call(this);
