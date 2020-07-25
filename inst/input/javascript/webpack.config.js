const path = require('path');

module.exports = {
  entry: {
    '#name#': './srcjs/inputs/#name#.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './inst/packer'),
  },
  externals: {
    jquery: 'jQuery',
    shiny: 'Shiny'
  },
};
