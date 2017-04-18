import React from 'react'
import {crel, div, input, text} from 'teact'
import {inject, observer} from 'mobx-react'
import SplitPane from 'react-split-pane'
import Dashboard from './Dashboard'
import AppBar from '../AppBar'
import ToolBar from '../ToolBar'
import Panel from './Panel'
import SettingsPanel from '../SettingsPanel'
import Button from '../Button'
TogglePanel = inject('panel')(observer(({panel}) ->
  handleClick = (=>
    console.log 'hi'
    panel.togglePanel('settings'))
  crel Button,
    icon: 'settings',
    intent: 'primary'
    isActive: !panel.panels.settings.isShowing
    onClick: handleClick
))



MainAppContainer = inject('app', 'panel')(observer(class MainAppContainer extends React.Component
  constructor: (props) ->
    super props

  render: ->
    topBar = 45
    dashboardBorder = 5
    {editor, borderStyle, app, panel} = @props
    {settings} = editor
    {grid} = settings
    div style: borderStyle, ->
      crel SplitPane, split: 'vertical', size: 70, allowResize: no, ->
        div style: borderStyle, ->
          div style: {height: topBar + 10}, className: 'column around', ->
            div className: 'row center middle', ->
              crel TogglePanel
          div style: padding: 5, className: 'pt-dark', ->
            crel ToolBar
        crel SplitPane, split: 'horizontal', size: topBar, allowResize: no, ->
          div style: width: grid.width + dashboardBorder*2, ->
            crel AppBar
          crel SplitPane, split: 'vertical', size: grid.width + dashboardBorder*2, allowResize: no, ->
            crel SplitPane, split: 'horizontal', size: grid.height + dashboardBorder*2, allowResize: no, ->
              crel Dashboard, grid: grid, editor: editor
              div style: borderStyle
            div style: borderStyle
      crel Panel,
        id: 'settings', =>
          crel SettingsPanel,
            app: app,
            editor: editor
            panel: panel.panels,
            settings: settings


))


MainAppView = inject('editor')(observer(({
  editor, borderStyle
}) ->
  displayName: 'MainContainer'
  switch editor.device
    when null
      div style: borderStyle
    else
      div style: borderStyle, ->
        crel MainAppContainer,
          editor: editor
          borderStyle: borderStyle

))




export default MainAppView

