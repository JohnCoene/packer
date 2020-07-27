const path = require('path');
const fs = require('fs');

var outputPath = fs.readFileSync('./srcjs/config/output_path.json');
var entryPoints = fs.readFileSync('./srcjs/config/entry_points.json');
var externals = fs.readFileSync('./srcjs/config/externals.json');
var loaders = fs.readFileSync('./srcjs/config/loaders.json', 'utf8');
loaders = JSON.parse(loaders);

loaders.forEach((loader) => {
  loader.test = RegExp(loader.test);
  return(loader);
})

var options = {
  entry: JSON.parse(entryPoints),
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, JSON.parse(outputPath)),
  },
  externals: JSON.parse(externals),
  module: {
    rules: loaders
  }
};

module.exports = options;
