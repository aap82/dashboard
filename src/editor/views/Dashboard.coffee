{crel, div} = require 'teact'
React = require 'react'
{inject, observer} = require 'mobx-react'
GridLayout = require 'react-grid-layout'
EditableWidget = require './Widget'
{sendCommand} = require('../../widgets/actions')


class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {editor} = @props
    {dashboard} = editor
    sendDeviceCommand = (platform, deviceId, command) =>
      if !editor.isEditing then sendCommand(platform, deviceId, command)




    div style: {
        position: 'relative'
        height: dashboard.height
        width: dashboard.width
        backgroundColor: dashboard.backgroundColor
        color: 'white'
      }, =>
        crel GridLayout,
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



module.exports = inject('editor')(observer(Dashboard))