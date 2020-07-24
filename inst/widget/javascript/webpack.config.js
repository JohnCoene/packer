const path = require('path');

module.exports = {
  entry: {
    '#name#': './srcjs/widgets/#name#.js',
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './inst/htmlwidgets'),
  },
  externals: {
    widgets: 'HTMLWidgets'
  },
};
