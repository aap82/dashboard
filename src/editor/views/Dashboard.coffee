{crel, div, pureComponent} = require 'teact'
React = require 'react'
{inject, observer} = require 'mobx-react'
ReactGridLayout = require 'react-grid-layout'
{ WidthProvider}  = require 'react-grid-layout'
GridLayout = WidthProvider(ReactGridLayout)
EditableWidget = require './Widget'
{crel, div} = require 'teact'



class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {editor} = @props
    {dashboard} = editor
    div style: dashboard.style, =>
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
        onLayoutChange: @handleLayoutChange
        Widgets(dashboard)



  handleLayoutChange: (layout) =>
    {dashboard} = @props.editor
    dashboard.layouts.replace(layout)



Widgets = pureComponent ( editor ) ->
  editor.widgets.map (widget) ->
    div key: widget.key, ->
      crel EditableWidget, widget: widget, type: widget.type



module.exports = inject('editor')(observer(Dashboard))