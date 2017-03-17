{crel, div, pureComponent} = require 'teact'
React = require 'react'
{inject, observer} = require 'mobx-react'
ReactGridLayout = require 'react-grid-layout'
{ WidthProvider}  = require 'react-grid-layout'
GridLayout = WidthProvider(ReactGridLayout)
EditableWidget = require './Widget'
{crel, div} = require 'teact'
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
            for layout, i in dashboard.layouts
              div key: layout.i, data: layout, =>
                crel EditableWidget, widget: dashboard.widgets[i], type: dashboard.widgets[i].type, sendCommand: sendDeviceCommand



  handleLayoutChange: (layout) =>
    {dashboard} = @props.editor
    console.log layout
    dashboard.layouts.replace(layout)


Widgets = pureComponent ( editor, sendCommand ) ->
  editor.widgets.map (widget) ->
    div key: widget.key, ->
      crel EditableWidget, widget: widget, type: widget.type, sendCommand: sendCommand



module.exports = inject('editor')(observer(Dashboard))