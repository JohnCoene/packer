const path = require('path');

module.exports = {
  entry: './srcjs/index.js',
  output: {
    filename: 'packer.js',
    path: path.resolve(__dirname, './inst/app/www'),
  },
  externals: {
    shiny: 'Shiny'
  },
};
