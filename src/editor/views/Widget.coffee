import React from 'react'
import {crel, div} from 'teact'
import {inject, observer} from 'mobx-react'
import Color from 'color'
import WidgetContainer from '../../widgets/Widget'
import { ContextMenuTarget, Menu, MenuItem } from  '@blueprintjs/core'


class EditableWidget extends React.Component
    constructor: (props) ->
      super props
    render: ->
      {widget, editor, dashboard, sendCommand} = @props
      {widgetCardDepth} = dashboard
      {device, label, type, widgetStyle} = widget
      class_name = if widget in editor.editingWidgets then 'selected-widget' else ''
      div className: class_name, style: {
        position: 'relative'
        height: '100%'
        width: '100%'
        display: 'block'
        clear: 'both'
        borderRadius: widgetStyle.borderRadius + 3
      }, onClick: @handleWidgetClick, ->
        crel WidgetContainer,
          label: label
          type: type
          cardDepth: widgetCardDepth
          style: widgetStyle
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




EditableWidget = inject(({modal, editor, widgetStore}, {id}) => ({
  modal: modal
  editor: editor
  widget: widgetStore.widgets.get(id)
}))(observer(EditableWidget))
export default EditableWidget





