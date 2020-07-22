const path = require('path');

module.exports = {
  entry: './srcjs/index.js',
  output: {
    filename: '#name#',
    path: path.resolve(__dirname, './inst/htmlwidgets'),
  }
};
