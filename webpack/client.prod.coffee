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
  name: 'client'
  entry:
    editor: path.join(paths.editor, 'prodEntry.coffee')
    widgets: path.join paths.widgets, 'widgets.scss'
    vendor: vendors
  output:
    path: paths.prodBuild
    filename: '[name].js'
    publicPath: '/'


  module:
    rules: [
      { test: /\.coffee$/, loader: 'coffee-loader', include: paths.src }
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
      'process.env.NODE_ENV': JSON.stringify('production')
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
      minimize: yes
      beautify: no
      sourceMap: no
      output:
        comments: false

      compressor:
        warnings: false
      mangle:
        except: ['webpackJsonp']
        screw_ie: yes
    })

    new ExtractTextPlugin({
      filename: 'styles/[name].css',
      allChunks: true
    })


  ]


config = merge(prodConfig, baseConfig)

module.exports = config