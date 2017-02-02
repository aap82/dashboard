require('dotenv').config()
path = require 'path'
getenv = require('getenv')
webpack = require 'webpack'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'
CleanWebpackPlugin = require('clean-webpack-plugin');
SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
SERVER_URL = 'http://' + SERVER_HOST + ':' + SERVER_PORT
DEV_SERVER_PORT = getenv 'DEV_SERVER_PORT'
DEV_SERVER_URL = 'http://' + SERVER_HOST + ':' + DEV_SERVER_PORT

vendors = require './vendors'
vendors.push '@blueprintjs/core'

HappyPack = require('happypack')

plugins = [
  new HappyPack({
    loaders: [ 'babel?presets[]=es2015' ],
  })

]

devConfig =
  entry:
    editor: [
      "react-hot-loader/patch"
      "#{path.join(paths.editor, 'hmrEntry.js')}"
    ]
    vendor: vendors


  output:
    filename: '[name].js'
    path: paths.devBuild
    publicPath: DEV_SERVER_URL + '/'
  devtool: 'inline-source-map'
  devServer:
    hot: yes
    contentBase: paths.devBuild
    port: DEV_SERVER_PORT
    inline: yes
    noInfo: no
    publicPath: DEV_SERVER_URL + '/'
    quiet: no
    filename: 'bundle.js'
  module:
    rules: [
#      { test: /\.js$/, use: ['babel-loader'], exclude: /node_modules/},
      { test: /\.(js|jsx)$/, loader: ['happypack/loader?id=js'], exclude: /node_modules/ , include: paths.src},
      { test: /\.coffee$/, loader: ['happypack/loader?id=coffee'], include: paths.src }
      { test: /\.(css|scss)$/, use: ['style-loader','css-loader', 'sass-loader'] }
    ]
  plugins: [
    new CleanWebpackPlugin(['build'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new HappyPack({
      id: 'js'
      loaders: [ 'babel-loader' ],
    })
    new HappyPack({
      id: 'coffee'
      loaders: [ 'coffee-loader' ],
    })
    new webpack.optimize.OccurrenceOrderPlugin()

    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('development')
    })

    new webpack.NamedModulesPlugin()
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor"
      filename: "vendors.js"
      minChunks: Infinity
    })
    new webpack.HotModuleReplacementPlugin(),
  ]

config = merge(devConfig, baseConfig)
module.exports = config