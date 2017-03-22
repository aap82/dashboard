require('dotenv').config()
path = require 'path'
getenv = require('getenv')
webpack = require 'webpack'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'
CleanWebpackPlugin = require('clean-webpack-plugin');
ExtractTextPlugin = require("extract-text-webpack-plugin")
nodeExternals = require('webpack-node-externals')
vendors = require './vendors'

prodClientConfig =
  context: paths.root
  resolve:
    alias:
      editor: paths.editor + '/'
      widgets: paths.widgets + '/'
      dashboard: paths.dashboard + '/'
    modules: ["node_modules", "#{path.src}"]
    extensions: ['.js', '.json',  '.jsx', '.coffee', '.css', '.scss']

  entry:
    dashboard: "#{path.join(paths.dashboard, 'prod_entry.js')}"
    editor: "#{path.join(paths.editor, 'prod_entry.js')}"
    register: "#{path.join(paths.register, 'Register.coffee')}"
    vendor: vendors
  output:
    filename: 'js/[name].js'
    path: paths.prodBuild
  module:
    rules: [
      { test: /\.coffee$/, use: [ 'babel-loader', 'coffee-loader' ], exclude: /node_modules/ ,include: paths.src }
      { test: /\.(js|jsx)$/, use: [ 'babel-loader'], exclude: /node_modules/ , include: paths.src},
      { test: /\.(png|woff|woff2|eot|ttf|svg)$/,  loader: ['url-loader'] }
      {
        test: /\.(css|scss)$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: ["css-loader", 'sass-loader']
        }),
      }

    ]
  plugins: [
    new CleanWebpackPlugin(['dist'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    })
    new webpack.optimize.OccurrenceOrderPlugin()
    new ExtractTextPlugin({
      filename: "css/[name].css"
      allChunks: yes
      disable: no
    })
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor"
      filename: "vendors.js"
      minChunks: Infinity
    })
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false,
        screw_ie8: true,
#        conditionals: true,
#        unused: true,
#        comparisons: true,
#        sequences: true,
        dead_code: true,
#        evaluate: true,
#        join_vars: true,
#        if_return: true
      },
      output: {
        comments: false
      }
    }),

  ]


prodServerConfig =
  target:       'node'
  devtool:       'source-maps'
  context:      paths.root
  resolve:      prodClientConfig.resolve
  entry:        "#{path.join(paths.dashboard, 'server_entry.coffee')}"
  output:
    path:           paths.prodBuild_Node
    filename:       'dashboard.js'
    libraryTarget:  'commonjs2'
  externals:    [nodeExternals()]
  module:       prodClientConfig.module
  plugins: [
    new CleanWebpackPlugin(['server/app'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    })
    new ExtractTextPlugin({
      filename: "[name].css"
      allChunks: yes
      disable: no
    })
  ]







module.exports = [prodClientConfig, prodServerConfig]