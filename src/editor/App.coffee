import {inject, observer} from 'mobx-react'
import {crel, div} from 'teact'
import SplitPane from 'react-split-pane'
import LeftPanel from './components/LeftPanel'
import DashboardContainer from './components/Dashboard'
import DeviceSettings from './components/Panels/DeviceSettings'

export default App = ->
  displayName: 'App'
  borderStyle =
    height: '100%'
    width: '100%'
    background: '#293742'
    color: 'white'
  div ->
    crel SplitPane, split: 'vertical', size: 210, allowResize: no, ->
      crel LeftPanel
      div style: borderStyle, ->
        crel DeviceSettings
        crel DashboardContainer, borderStyle: borderStyle

