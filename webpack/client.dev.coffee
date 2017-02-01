path = require 'path'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'

devConfig =
  entry:
    editor: path.join(paths.editor, 'devEntry.coffee')
  output:
    path: paths.prodBuild
    filename: '[name].js'
  module:
    rules: [
      {
        test: /\.css$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: { modules: true }
          },
        ],
      }
      {
        test: /\.scss$/,
        use: ['style-loader','css-loader','sass-loader']
      }
    ]


config = merge(devConfig, baseConfig)

module.exports = config