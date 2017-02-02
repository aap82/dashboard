path = require 'path'
webpack = require 'webpack'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'
CleanWebpackPlugin = require('clean-webpack-plugin');
devConfig =
  name: 'client'
  devtool: 'cheap-eval-source-map'
  context: paths.root
  entry: [
    "#{path.join(paths.editor, 'devEntry.coffee')}"
  ]
  output:
    path: paths.devBuild
    filename: 'bundle.js'
    publicPath: '/'
  resolve:
    alias:
      editor: paths.editor + '/'
      widgets: paths.widgets + '/'
    modules: ["node_modules"]
    extensions: ['.js', '.json',  '.jsx', '.coffee', '.css', '.scss']
  module:
    rules: [
      { test: /\.(css|scss)$/, loaders: ['style-loader','css-loader', 'sass-loader'], include: paths.src }
      { test: /\.coffee$/, loader: 'coffee-loader', include: paths.src }
      { test: /\.(png|woff|woff2|eot|ttf|svg)$/,  loader: ['url-loader'] }
    ]
  plugins: [
    new CleanWebpackPlugin(['build'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('development')
    })

    new webpack.NamedModulesPlugin()

  ]

module.exports = devConfig