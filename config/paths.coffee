path = require('path')
root = path.join __dirname, '..'


paths =
  root:           root
  node_modules:   path.join root, 'node_modules'
  src:            path.join root, 'src'
  editor:         path.join root, 'src', 'editor'
  dashboard:      path.join root, 'src', 'dashboard'
  register:       path.join root, 'src', 'register'
  widgets:        path.join root, 'src', 'widgets'
  styles:         path.join root, 'src', 'styles'
  server:         path.join root, 'server'
  views:          path.join root, 'server', 'views'
  publicFiles:    path.join root, 'public'
  devBuild:       path.join root, 'build'
  node_entry:     path.join root, 'src', 'dashboard'
  prodBuild:      path.join root, 'dist'
  prodBuild_Node: path.join root, 'server', 'app'
  blueprintCSS:   path.join root, 'node_modules', '@blueprintjs', 'core', 'dist', 'blueprint.css'

module.exports = paths