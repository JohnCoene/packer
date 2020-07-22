const path = require('path');

module.exports = {
  entry: './srcjs/index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [ '.tsx', '.ts', '.js' ],
  },
  output: {
    filename: '#name#',
    path: path.resolve(__dirname, './inst/htmlwidgets'),
  },
};
