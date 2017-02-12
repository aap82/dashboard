{crel, div, pureComponent} = require 'teact'
React = require 'react'
{toJS} = require 'mobx'
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
  console.log 'rendering widgets'
  editor.widgets.map (widget) ->
    state = if deviceStates[widget.device.id]? then deviceStates[widget.device.id] else {}
    div key: widget.key,  ->
      switch editor.isEditing
        when yes then crel EditableWidget, widget: widget, editor: editor, widgetEditor: widgetEditor, modal: modal, state: state
        else
          div widget.key, style: widgetStyle, =>
            crel Widget, widget: widget, state: state

class Dashboard extends React.Component
  render: ->
    {editor, widgetEditor, modal, states, editorView} = @props
    {dashboard} = editorView
    style =
      position: 'relative'
      height: '100%'
      backgroundColor: dashboard.backgroundColor

    div style: style, ->
      crel GridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: editorView.isEditing
        isResizable: editorView.isEditing
        cols: dashboard.cols
        margin: [dashboard.marginX, dashboard.marginY]
        containerPadding: [0, 0]
        rowHeight: dashboard.rowHeight
        layout: (dashboard.layouts).slice()
        onLayoutChange: @handleLayoutChange
        Widgets editor, widgetEditor, modal, states


  handleLayoutChange: (layout) =>
    @props.editor.newLayout = layout
    console.log layout







module.exports = inject('widgetEditor', 'editorView', 'editor', 'modal', 'states')(observer(Dashboard))