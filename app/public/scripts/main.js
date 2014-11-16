(function() {
  var colors, compileTemplates, createMorrisChart, init, kleinVariables, letters, processKleinData, renderChart, times, xLabelsAtoE, xLabelsFtoG,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  letters = 'abcdefg';

  colors = ['rgb(122, 146, 163)', 'rgb(11, 98, 164)', 'rgb(77, 167, 77)'];

  times = ['past', 'present', 'ideal'];

  xLabelsAtoE = ['Other Sex Only', 'Other Sex Mostly', 'Other Sex Somewhat More', 'Both Sexes Equally', 'Same Sex Somewhat More', 'Same Sex Mostly', 'Same Sex Only'];

  xLabelsFtoG = ['Hetero Only', 'Hetero Mostly', 'Hetero Somewhat More', 'Hetero/Gay or Lesbian Equally', 'Gay or Lesbian Somewhat More', 'Gay or Lesbian Mostly', 'Gay or Lesbian Only'];

  kleinVariables = {
    a: 'Sexual Attraction',
    b: 'Sexual Behavior',
    c: 'Sexual Fantasies',
    d: 'Emotional Preferences',
    e: 'Social Preferences',
    f: 'Hetero or Homo Lifestyle',
    g: 'Self Identification'
  };

  compileTemplates = function() {
    return cint.toObject($('.template'), function(el) {
      var templateFunction;
      templateFunction = Handlebars.compile($(el).html());
      return cint.keyValue($(el).attr('data-template-name'), templateFunction);
    });
  };

  processKleinData = function(kleinDataObjects) {
    var talliedAData;
    talliedAData = cint.tallyProps(kleinDataObjects);
    return cint.toArray(talliedAData, function(key, value) {
      return _.extend({
        klein: key
      }, value);
    });
  };

  createMorrisChart = function(el, morrisData) {
    return new Morris.Bar({
      element: el,
      data: morrisData,
      xkey: 'klein',
      ykeys: times,
      labels: times.map(cint.toTitleCase),
      barColors: colors,
      smooth: false,
      resize: true,
      hideHover: true
    });
  };

  renderChart = function(parent, templateFunction, templateData, morrisData) {
    var chart;
    chart = $('<div>').addClass('chart').appendTo(parent).html(templateFunction(templateData));
    createMorrisChart($('.chart-container', chart), morrisData);
    return chart;
  };

  init = function() {
    var kleinVariableLabel, letter, morrisData, templateData, templates, xLabelSet, xLabels, _results;
    templates = compileTemplates();
    _results = [];
    for (letter in kleinVariables) {
      kleinVariableLabel = kleinVariables[letter];
      morrisData = processKleinData(_.pluck(kleinData, letter));
      xLabelSet = __indexOf.call('abcde', letter) >= 0 ? xLabelsAtoE : xLabelsFtoG;
      xLabels = _.pluck(morrisData, 'klein').map(function(n) {
        return n - 1;
      }).map(cint.index.bind(null, xLabelSet));
      templateData = {
        title: kleinVariableLabel,
        yLabel: '# of Respondents',
        xLabel: 'Klein Scale',
        subXLabels: xLabels.map(function(label, i) {
          return {
            label: label,
            width: 100 / xLabels.length
          };
        })
      };
      _results.push(renderChart('.charts', templates.chartTemplate, templateData, morrisData));
    }
    return _results;
  };

  init();

}).call(this);
