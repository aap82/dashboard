React = require 'react'
{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'
Color = require 'color'
WidgetContainer = require '../../widgets/Widget'
{ ContextMenuTarget, Menu, MenuItem } = require '@blueprintjs/core'


FixPositionMenuItem = observer(({layouts, idx, handleClick}) =>
  checked = layouts[idx].static
  icon = if checked then 'small-tick' else 'small-tick'
  text = if checked then 'Unfix Position' else 'Fix Position'
  crel MenuItem, className: 'pt-fill', iconName: icon, text: text, onClick: handleClick

)



ContextMenuTarget(
  observer(class EditableWidget extends React.Component
    constructor: (props) ->
      super props
      @layoutIndex = props.editor.dashboard.layouts.findIndex((l) -> l.i is props.widget.key)
      console.log @layoutIndex


    getGlobalStyle: (dashboard) =>
      backgroundColor: Color(dashboard.widgetBackgroundColor).alpha(dashboard.widgetBackgroundAlpha/100).hsl().string()
      color: dashboard.widgetFontColor
      borderRadius: dashboard.widgetBorderRadius



    render: ->
      {widget, editor, sendCommand} = @props
      {dashboard} = editor
      {widgetCardDepth} = dashboard
      {device, label, type} = widget
      widget.style = if widget.overrideStyle then widget.style else @getGlobalStyle(dashboard)


      div style: {
        position: 'relative'
        height: '100%'
        width: '100%'
        display: 'block'
        clear: 'both'
      }, ->
        crel WidgetContainer,
          label: label
          type: type
          cardDepth: widgetCardDepth
          style: widget.style
          device: device
          sendCommand: sendCommand


    renderContextMenu: =>
      {editor, widget} = @props
      {dashboard} = editor
      {layouts} = dashboard

      if !editor.isEditing then return null
      crel Menu, style: {width: 40}, =>
        crel FixPositionMenuItem, layouts: layouts, idx: @layoutIndex, handleClick: @handleStaticWidget
        crel MenuItem, className: 'pt-fill', iconName: 'edit', onClick: @handleEditWidget, text: 'Edit'
        crel MenuItem, className: 'pt-fill', iconName: 'delete', onClick: @handleDeleteWidget, text: 'Delete'

    handleStaticWidget: (e) =>
      @props.editor.toggleWidgetStaticness(@layoutIndex)


    handleEditWidget: (e) =>
      {widget} = @props
      if widget.label?
        @props.modal.open('editWidget')

    handleDeleteWidget: =>
      {widget, editor} = @props

      editor.dashboard.widgets.remove(widget)
      return
  )

)

module.exports = inject('modal', 'editor')(observer(EditableWidget))





