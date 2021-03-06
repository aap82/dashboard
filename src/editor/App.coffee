import {inject, observer} from 'mobx-react'
import {crel, div} from 'teact'
import SplitPane from 'react-split-pane'
import LeftPanel from './components/LeftPanel'
import MainContainer from './components/Main'




export default App = ->
  displayName: 'App'
  leftPaneWidth = 210
  borderStyle =
    height: '100%'
    width: '100%'
    background: '#293742'
    color: 'white'

  div className: 'pt-dark', ->
    crel SplitPane, split: 'vertical', size: leftPaneWidth, allowResize: no, ->
      crel LeftPanel
      crel MainContainer, leftBound: leftPaneWidth, borderStyle: borderStyle

