const path = require('path');

module.exports = {
  entry: './srcjs/index.js',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, './inst/packer'),
  }
};
