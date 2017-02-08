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





Widgets = pureComponent (dashboard, editor, widgetEditor, modal, deviceStates) ->
  dashboard.widgets.map (widget) ->
    state = if deviceStates[widget.device.id]? then deviceStates[widget.device.id] else {}
    div key: widget.key,  ->
      switch dashboard.isEditing
        when yes then crel EditableWidget, widget: widget, editor: editor, widgetEditor: widgetEditor, modal: modal, state: state
        else
          div widget.key, style: widgetStyle, =>
            crel Widget, widget: widget, state: state




class Dashboard extends React.Component
  render: ->
    {editor, dashboard, widgetEditor, modal, states} = @props
    div style: dashboard.dashboardStyle, =>
      crel GridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: dashboard.isEditing
        isResizable: dashboard.isEditing
        cols: dashboard.cols
        margin: [dashboard.marginX, dashboard.marginY]
        containerPadding: [0, 0]
        rowHeight: dashboard.rowHeight
        layout: (dashboard.layouts).slice()
        onLayoutChange: @handleLayoutChange
        Widgets dashboard, editor, widgetEditor, modal, states


  handleLayoutChange: (layout) => @props.editor.newLayout = layout







module.exports = inject('widgetEditor', 'dashboard', 'editor', 'modal', 'states')(observer(Dashboard))