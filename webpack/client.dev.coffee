path = require 'path'
paths = '../config/paths'


module.exports =
  devtool: 'cheap-eval-source-map'
  context: paths.src
  entry:
    editor: path.join(path.editor, 'devEntry.coffee')

  output:
    path: path.devBuild
    filename: '[name].bundle.js'


