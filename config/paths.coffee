path = require('path')
root = path.join __dirname, '..'


paths =
  root:           root
  node_modules:   path.join root, 'node_modules'
  src:            path.join root, 'src'
  editor:         path.join root, 'src', 'editor'
  widgets:        path.join root, 'src', 'widgets'
  styles:         path.join root, 'src', 'styles'
  server:         path.join root, 'server'
  views:          path.join root, 'server', 'views'
  devBuild:       path.join root, 'build'
  prodBuild:      path.join root, 'dist'
  blueprintCSS:   path.join root, 'node_modules', '@blueprintjs', 'core', 'dist', 'blueprint.css'

module.exports = paths