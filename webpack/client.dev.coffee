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
module.exports =
  entry: [
    "react-hot-loader/patch"
    "#{path.join(paths.editor, 'hmrEntry.js')}"
  ]


  output:
    filename: 'bundle.js'
    path: paths.devBuild
    publicPath: DEV_SERVER_URL + '/'
  context: paths.root
  devtool: 'inline-source-map'
  devServer:
    hot:yes
    contentBase: paths.devBuild
    port: DEV_SERVER_PORT
    inline: yes
    noInfo: no
    publicPath: DEV_SERVER_URL + '/'
    quiet: no
    filename: 'bundle.js'
  resolve:
    alias:
      editor: paths.editor + '/'
      widgets: paths.widgets + '/'
    modules: ["node_modules"]
    extensions: ['.js', '.json',  '.jsx', '.coffee', '.css', '.scss']
  module:
    rules: [
      { test: /\.js$/, use: ['babel-loader'], exclude: /node_modules/},
      { test: /\.(css|scss)$/, use: ['style-loader','css-loader', 'sass-loader'] }
      { test: /\.coffee$/, loader: 'coffee-loader', include: paths.src }
      { test: /\.(png|woff|woff2|eot|ttf|svg)$/,  loader: ['url-loader'] }
    ]
  plugins: [
    new CleanWebpackPlugin(['build'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new webpack.HotModuleReplacementPlugin(),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('development')
    })

    new webpack.NamedModulesPlugin()

  ]

