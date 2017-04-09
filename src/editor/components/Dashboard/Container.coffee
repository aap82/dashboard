import React from 'react'
import {crel, div, input, text} from 'teact'
import {inject, observer} from 'mobx-react'
import SplitPane from 'react-split-pane'
import Dashboard from './Dashboard'
import AppBar from '../AppBar'
import ToolBar from '../ToolBar'

class DashboardContainer extends React.Component
  constructor: (props) ->
    super props

  render: ->
    topBar = 50

    {editor, borderStyle} = @props
    {device} = editor
    {grid} = device.settings
    console.log borderStyle
    crel SplitPane, split: 'vertical', size: 100, allowResize: no, ->
      div style: borderStyle, ->
        div style: minHeight: topBar
        div style: padding: 5, className: 'pt-dark', ->
          crel ToolBar
      crel SplitPane, split: 'horizontal', size: topBar, allowResize: no, ->
        div style: width: grid.width + 20, ->
          crel AppBar
        crel SplitPane, split: 'vertical', size: grid.width + 20, allowResize: no, ->
          crel SplitPane, split: 'horizontal', size: grid.height + 20, allowResize: no, ->
            div style: {backgroundColor: 'black', padding: 10}, ->
              div style: {
                height: grid.height
                width: grid.width
                backgroundColor: grid.backgroundColor.color
              }
            div style: borderStyle
          div style: borderStyle



DashboardContainer = inject('editor')(observer(DashboardContainer))

export default DashboardContainer


#
#crel SplitPane, split: 'vertical', size: grid.width + 20, allowResize: no, ->
#  crel SplitPane, split: 'horizontal', size: 40, allowResize: no, ->
#    div style: borderStyle, ->
#      crel AppBar
#    crel SplitPane, split: 'horizontal', size: grid.height + 20, allowResize: no, ->
#      div style: {backgroundColor: 'black', padding: 10}, ->
#        div style: {
#          height: grid.height
#          width: grid.width
#          backgroundColor: grid.backgroundColor.color
#        }
#      div style: borderStyle
#  div style: borderStyle
#
