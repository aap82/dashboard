import React from 'react'
import {crel, div, input, text} from 'teact'
import {inject, observer} from 'mobx-react'
import SplitPane from 'react-split-pane'
import Dashboard from './Dashboard'
import AppBar from '../AppBar'
import ToolBar from '../ToolBar'

DashboardContainer = observer(class DashboardContainer extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {grid, editor} = @props
    div style: {
      height: grid.height
      width: grid.width
      backgroundColor: "#{grid.backgroundColor}"
    }, "#{editor.isDirty}"





)

export default DashboardContainer

