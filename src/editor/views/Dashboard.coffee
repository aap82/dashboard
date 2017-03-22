import {crel, div} from 'teact'
import React from 'react'
import {inject, observer} from 'mobx-react'
import ReactGridLayout from 'react-grid-layout'
import EditableWidget from './Widget'
{sendCommand} = require('../../widgets/actions')

import cx from 'classnames'
class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {editor} = @props
    {dashboard} = editor
    sendDeviceCommand = (platform, deviceId, command) =>
      if !editor.isEditing then sendCommand(platform, deviceId, command)

    className = cx(
      'primary-font-size-'+ dashboard.widgetFontSizePrimary,
      'secondary-font-size-'+ dashboard.widgetFontSizeSecondary
    )



    div style: {
        position: 'relative'
        height: dashboard.height
        width: dashboard.width
        backgroundColor: dashboard.backgroundColor
        color: 'white'
      }, className: className, =>
        crel ReactGridLayout,
          verticalCompact: no
          autoSize: no
          isDraggable: editor.isEditing
          isResizable: editor.isEditing
          cols: dashboard.cols
          margin: [dashboard.marginX, dashboard.marginY]
          containerPadding: [0, 0]
          rowHeight: dashboard.rowHeight
          width: dashboard.width
          layout: dashboard.layouts.slice()
          onLayoutChange: @handleLayoutChange, =>
            for widget in dashboard.widgets
              div key: widget.key,  =>
                crel EditableWidget, dashboard: dashboard, widget: widget, sendCommand: sendDeviceCommand
#
#            for layout, i in dashboard.layouts
#              div key: layout.i, data: layout, =>
#                crel EditableWidget, dashboard: dashboard, widget: dashboard.widgets[i], type: dashboard.widgets[i].type, sendCommand: sendDeviceCommand



  handleLayoutChange: (layout) =>
    {editor} = @props
    editor.updateLayout(layout)



export default inject('editor')(observer(Dashboard))