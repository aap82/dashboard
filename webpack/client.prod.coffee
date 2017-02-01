webpack = require 'webpack'
path = require 'path'
glob = require('glob')
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'
vendors = require './vendors'
ExtractTextPlugin = require('extract-text-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin');
UglifyJSPlugin = require('uglifyjs-webpack-plugin')
#PurifyCSSPlugin = require('purifycss-webpack')
prodConfig =

  entry:
    editor: path.join(paths.editor, 'prodEntry.coffee')
    vendor: vendors
  output:
    path: paths.prodBuild
    filename: '[name].js'


  module:
    rules: [
      {
        test: /\.(css|scss)$/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style-loader',
          loader: ['css-loader', 'sass-loader']
        })
      }
    ]


  plugins: [
    new webpack.DefinePlugin({
        NODE_ENV: 'production'
    })
    new CleanWebpackPlugin(['dist'], {
      root: paths.root
      verbose: true,
      dry: false,
    })


    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor"
      filename: "vendors.js"
      minChunks: Infinity
    })

    new UglifyJSPlugin({
      minimize: true
      sourceMap: false
      output:
        comments: false

      compressor:
        warnings: false

    })

    new ExtractTextPlugin({
      filename: 'styles/[name].css',
      allChunks: true
    })


  ]


config = merge(prodConfig, baseConfig)

module.exports = config