{crel, div, pureComponent} = require 'teact'
React = require 'react'
{inject, observer} = require 'mobx-react'
ReactGridLayout = require 'react-grid-layout'
{ WidthProvider}  = require 'react-grid-layout'
GridLayout = WidthProvider(ReactGridLayout)
Widget = require './Widget'
{crel, div} = require 'teact'
React = require 'react'
{ ContextMenuTarget, Menu, MenuItem } = require '@blueprintjs/core'



widgetStyle =
  position: 'relative'
  height: '100%'
  width: '100%'
  display: 'block'
  clear: 'both'


ContextMenuTarget(
  observer(class EditableWidget extends React.Component
    render: ->
      {widget, state} = @props
      div widget.key, style: widgetStyle, =>
        crel Widget, widget: widget, state: state


    renderContextMenu: =>
      crel Menu, style: {width: 40}, =>
        crel MenuItem, className: 'pt-fill', iconName: 'edit', onClick: @handleEditWidget, text: 'Edit'
        crel MenuItem, className: 'pt-fill', iconName: 'delete', onClick: @handleDeleteWidget, text: 'Delete'

    handleEditWidget: (e) =>
      {widget} = @props
      if widget.label?
        @props.widgetEditor.startEditing(widget)
        @props.modal.showEditWidgetDialog()

    handleDeleteWidget: (e) =>
      {widget} = @props
      @props.editor.deleteWidget(widget)
      return
  )
)





Widgets = pureComponent ( editor, widgetEditor, modal, deviceStates) ->
  editor.widgets.map (widget) ->
    state = if deviceStates[widget.device.id]? then deviceStates[widget.device.id] else {}
    div key: widget.key,  ->
      switch dashboard.isEditing
        when yes then crel EditableWidget, widget: widget, editor: editor, widgetEditor: widgetEditor, modal: modal, state: state
        else
          div widget.key, style: widgetStyle, =>
            crel Widget, widget: widget, state: state




class Dashboard extends React.Component
  render: ->
    {editor, widgetEditor, modal, states} = @props
    div style: editor.dashboardStyle, =>
      crel GridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: editor.isEditing
        isResizable: editor.isEditing
        cols: editor.cols
        margin: [editor.marginX, editor.marginY]
        containerPadding: [0, 0]
        rowHeight: editor.rowHeight
        layout: (editor.layouts).slice()
        onLayoutChange: @handleLayoutChange
        Widgets editor, widgetEditor, modal, states


  handleLayoutChange: (layout) => @props.editor.newLayout = layout







module.exports = inject('widgetEditor', 'editor', 'modal', 'states')(observer(Dashboard))