const path = require('path');
const fs = require('fs');

// Read config files
var outputPath = fs.readFileSync('./srcjs/config/output_path.json');
var entryPoints = fs.readFileSync('./srcjs/config/entry_points.json');
var externals = fs.readFileSync('./srcjs/config/externals.json');
var loaders = fs.readFileSync('./srcjs/config/loaders.json', 'utf8');
loaders = JSON.parse(loaders);

// parse regex
loaders.forEach((loader) => {
  loader.test = RegExp(loader.test);
  return(loader);
})

// placeholder for plugins
var plugins = [

];

// define options
var options = {
  entry: JSON.parse(entryPoints),
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, JSON.parse(outputPath)),
  },
  externals: JSON.parse(externals),
  module: {
    rules: loaders
  },
  plugins: plugins
};

// export
module.exports = options;
