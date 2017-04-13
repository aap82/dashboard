import {crel, div} from 'teact'
import React from 'react'
import {inject, observer} from 'mobx-react'
import ReactGridLayout from 'react-grid-layout'
import EditableWidget from './Widget'

{sendCommand} = require('../../widgets/actions')

import cx from 'classnames'


class DashboardContainer extends React.Component
  constructor: (props) ->
    super (props)

  render: ->

    {app} = @props
    {dashboard} = app
    className = cx(
      'primary-font-size-'+ 18
      'secondary-font-size-'+ 14
    )
    div style: dashboard.style, className: className, =>
      crel 'div', @props.children


DashboardContainer = inject('app')(observer(DashboardContainer))



class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {app} = @props
    {dashboard, editor, newDevice} = app
    {grid} = dashboard
    sendDeviceCommand = (platform, deviceId, command) =>
      if !grid.isEditing then sendCommand(platform, deviceId, command)
    crel DashboardContainer, =>
      crel ReactGridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: yes
        isResizable: yes
        cols: grid.cols
        margin: [grid.marginX, grid.marginY]
        containerPadding: [0, 0]
        maxRows: grid.maxRows
        rowHeight: grid.rowHeight
        width: newDevice.width
        layout: []
        onLayoutChange: @handleLayoutChange, =>
          for widget in dashboard.widgets
            div key: widget.key,  =>
              crel EditableWidget, dashboard: editor.dashboard, parent: dashboard.uuid, id: widget.uuid, sendCommand: sendDeviceCommand
#
#            for layout, i in dashboard.layouts
#              div key: layout.i, data: layout, =>
#                crel EditableWidget, dashboard: dashboard, widget: dashboard.widgets[i], type: dashboard.widgets[i].type, sendCommand: sendDeviceCommand



  handleLayoutChange: (layout) =>
    {editor} = @props
    editor.updateLayout(layout)



Dashboard = inject('app')(observer(Dashboard))

export default Dashboard