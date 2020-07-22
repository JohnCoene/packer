const path = require('path');

module.exports = {
  entry: './srcjs/index.js',
  output: {
    filename: '#FILE#',
    path: path.resolve(__dirname, './inst/htmlwidgets'),
  }
};
