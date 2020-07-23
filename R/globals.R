# globals in case it needs changing in the future
SRC <- "srcjs"
WEBPACK_CONFIG <- "webpack.config.js"

# add css module
css_module_base <- "module: {
  rules: [
    {
      test: /\\.css$/,
      use: [
        'style-loader',
        'css-loader',
      ],
    },
  ],
},"
