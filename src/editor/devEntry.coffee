require '../widgets/widgets.scss'
require './styles.scss'
{crel} = require 'teact'
DevTools = require('mobx-react-devtools').default
App = require('./views/App')


options =
  highlightTimeout: 800
  setGraphEnabled: yes
  position:
    bottom: 0
    left: 150

DevApp = ->
  displayName: 'DevApp'
  crel 'div', ->
    crel App
    crel DevTools, options





module.exports = DevApp

