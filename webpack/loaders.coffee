module.exports =
  rules: [{
    test: /\.coffee$/,
    include: __dirname + '/src',
    use: [{
      loader: 'babel-loader',
      options: {
        presets: [
          ['es2015', { modules: false }]
        ]
      }
    }]
  }]

