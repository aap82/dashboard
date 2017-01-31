path = require('path')
root = path.join __dirname, '..'


paths =
  root:           root
  node_modules:   path.join root, 'node_modules'
  src:            path.join root, 'src'
  editor:         path.join root, 'src', 'editor'
  devBuild:       path.join root, 'build'
  prodBuild:      path.join root, 'dist', 'editor'

module.exports = paths