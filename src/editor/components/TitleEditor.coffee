React = require 'react'
{crel, div, span, h3, h4, h5, text, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Popover, EditableText, Position} =  require('@blueprintjs/core')


Title = observer(({widget, onChange}) ->
  {activeWidget} = widget
  h4 ->
    crel EditableText,
      placeholder: activeWidget.title or ''
      value: activeWidget.title or ''
      selectAllOnFocus: yes
      onChange: onChange
)





class WidgetTitleEditor extends React.Component
  handleTitleChange: => console.log 'hi'

  render: ->
    {widgetEditor} = @props
    content = crel(Title, {widget: widgetEditor, onChange: @handleTitleChange})
    crel Popover,
      content: content
      isOpen: widgetEditor.isTitleEditorOpen, ->
        div ''

module.exports = inject('widgetEditor')(observer(WidgetTitleEditor))

