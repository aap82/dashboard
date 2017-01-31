path = require 'path'
paths = require '../config/paths.coffee'


module.exports =
  context: paths.root
  entry:
    editor: path.join(paths.editor, 'prodEntry.coffee')
  resolve:
    modules: ["node_modules"]
    extensions: ['.js', '.coffee', '.scss']

  output:
    path: paths.prodBuild
    filename: '[name].js'

  module:
    rules: [
      {
        test: /\.coffee$/
        include: paths.src
        use: [{
          loader: 'coffee-loader'
        }]


      }
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
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      }
      {
        test: /\.(png|woff|woff2|eot|ttf|svg)$/
        use: [
          'url-loader'
        ]
      }

   ]

