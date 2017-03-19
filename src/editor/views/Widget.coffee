React = require 'react'
{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'
Color = require 'color'
WidgetContainer = require '../../widgets/Widget'
{ ContextMenuTarget, Menu, MenuItem } = require '@blueprintjs/core'


class EditableWidget extends React.Component
    constructor: (props) ->
      super props

#
#    componentWillReceiveProps: (nextProps) =>
#      {widget, editor, dashboard} = nextProps
#      return if !editor.isEditing
#      return if editor.editingWidgets.length isnt 1
#      if widget.key is editor.editingWidgets[0].key
#        layout = _getWidgetLayout(widget, dashboard)
#        editor.editingLayouts.replace([layout])


    getGlobalStyle: (dashboard) ->
      backgroundColor: Color(dashboard.widgetBackgroundColor).alpha(dashboard.widgetBackgroundAlpha/100).hsl().string()
      color: dashboard.widgetFontColor
      borderRadius: dashboard.widgetBorderRadius

    render: ->
      {widget, editor, dashboard, sendCommand} = @props
      {widgetCardDepth} = dashboard
      {device, label, type} = widget
      widget.style = if widget.overrideStyle then widget.style else @getGlobalStyle(dashboard)
      class_name = if widget in editor.editingWidgets then 'selected-widget' else ''

      div className: class_name, style: {
        position: 'relative'
        height: '100%'
        width: '100%'
        display: 'block'
        clear: 'both'
        borderRadius: widget.style.borderRadius + 3
      }, onClick: @handleWidgetClick, ->
        crel WidgetContainer,
          label: label
          type: type
          cardDepth: widgetCardDepth
          style: widget.style
          device: device
          sendCommand: sendCommand




    handleWidgetClick: (e) =>
      {editor, widget} = @props
      return if !editor.isEditing
      {dashboard} = editor
      if !e.ctrlKey
        if editor.editingWidgets.length is 1 and widget.key is editor.editingWidgets[0].key
          editor.editingWidgets.clear()
          editor.editingLayouts.clear()
        else
          editor.editingWidgets.clear()
          editor.editingLayouts.clear()
          _addWidgetAndLayout(widget, dashboard, editor)
      else
        if widget in editor.editingWidgets
          _removeWidgetAndLayout(widget, dashboard, editor)
        else
          _addWidgetAndLayout(widget, dashboard, editor)






    handleDeleteWidget: =>
      {widget, editor} = @props
      editor.dashboard.widgets.remove(widget)
      return

    _removeWidgetAndLayout = (widget, dashboard, editor) ->
      layout = _getWidgetLayout(widget, dashboard)
      editor.editingWidgets.remove(widget)
      editor.editingLayouts.remove(layout)


    _addWidgetAndLayout = (widget, dashboard, editor) ->
      layout = _getWidgetLayout(widget, dashboard)
      editor.editingWidgets.push(widget)
      editor.editingLayouts.push(layout)

    _getWidgetLayout = (widget, dashboard) ->
      layoutIndex = dashboard.layouts.findIndex((l) -> l.i is widget.key)
      return dashboard.layouts[layoutIndex]





module.exports = inject('modal', 'editor')(observer(EditableWidget))





