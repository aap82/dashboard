path = require 'path'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './client.base'
vendors = require './vendors'
devConfig =
  entry:
    editor: path.join(paths.editor, 'devEntry.coffee')
    vendor: vendors
  output:
    path: paths.devBuild
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
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('development')
    })
    new CleanWebpackPlugin(['build'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new NpmInstallPlugin({
      dev: yes,
      peerDependencies: no,
    })
  ]
config = merge(devConfig, baseConfig)

module.exports = config