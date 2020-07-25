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
