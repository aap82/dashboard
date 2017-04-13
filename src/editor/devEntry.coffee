import {crel} from 'teact'
require '../widgets/widgets.scss'
require './styles.scss'

import DevTools from 'mobx-react-devtools'
import App from './App'


options =
  highlightTimeout: 800
  setGraphEnabled: yes
  position:
    bottom: 0
    left: 150

export default DevApp = ->
  displayName: 'DevApp'
  crel 'div', ->
    crel App
    crel DevTools, options







