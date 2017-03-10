React = require 'react'
{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'

WidgetContainer = require '../../widgets/Widget'
{ ContextMenuTarget, Menu, MenuItem } = require '@blueprintjs/core'

ContextMenuTarget(
  observer(class EditableWidget extends React.Component
    render: ->
      {widget} = @props
      {props, device, style} = widget
      thisStyle =
        position: 'relative'
        height: '100%'
        width: '100%'
        display: 'block'
        clear: 'both'
      div style: thisStyle, ->
        crel WidgetContainer,
          props: props
          style: style
          device: device


    renderContextMenu: =>
      crel Menu, style: {width: 40}, =>
        crel MenuItem, className: 'pt-fill', iconName: 'edit', onClick: @handleEditWidget, text: 'Edit'
        crel MenuItem, className: 'pt-fill', iconName: 'delete', onClick: @handleDeleteWidget, text: 'Delete'

    handleEditWidget: (e) =>
      {widget} = @props
      if widget.label?
#        @props.widgetEditor.startEditing(widget)
        @props.modal.open('editWidget')

    handleDeleteWidget: (e) =>
      {widget} = @props
      @props.editor.deleteWidget(widget)
      return
  )

)
NonEditableWidget = ({widget}) ->
  {props, device, style} = widget
  crel WidgetContainer,
    props: props
    style: style
    device: device


NonEditableWidget.displayName = 'NonEditingWidget'

EditorWidget = observer((props) ->
  switch props.editor.isEditing
    when yes
      crel EditableWidget, props
    else
      crel NonEditableWidget, props
)

EditorWidget.displayName = 'EditorWidget'



module.exports = inject((stores) => ({
  modal: stores.modal
  editor: stores.editor
}))(observer(EditorWidget))





