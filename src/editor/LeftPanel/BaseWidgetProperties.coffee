React = require 'react'
{crel, div, br, text, input} = require 'teact'
{ observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')
{WidgetBackgroundColorPicker, WidgetFontColorPicker} = require './ColorPicker'

BaseWidgetPropertiesTitleButton = ->
    crel Button,
      text: 'Base Widget Properties'
      iconName: 'caret-down'
      className: 'pt-minimal pt-fill pt-large'


WidgetProp = observer(({id, editor, increment, decrement, onChange}) ->
  value = editor.widgetProps[id]
  div className: 'number-input-container', =>
    div className: 'input-section', =>
      input
        id: id
        className: 'pt-input pt-rtl number-input'
        value: editor.widgetProps[id]
        type: 'text'
        onChange: onChange
        disabled: !editor.isEditing
        autoFocus: yes
      crel Button, id: id,iconName: 'pt-icon pt-icon-plus toggle-icon',  value: value, onClick: increment, disabled: !editor.isEditing
      crel Button, id: id,iconName: 'pt-icon pt-icon-minus toggle-icon',  value: value, onClick: decrement, disabled: !editor.isEditing

)


class BaseWidgetPropertiesContent extends React.Component
  increment: (e) =>
    {editor} = @props
    value = parseInt(e.target.value, 10)
    return if e.target.id is 'cardDepth' and value > 4
    value++
    editor.setWidgetEditorProp(e.target.id, value)
    return

  decrement: (e) =>
    {editor} = @props
    value = parseInt(e.target.value, 10)
    if value is 0 then return else value--
    return editor.setWidgetEditorProp(e.target.id, value)

  handleChange: (e) =>
    {editor} = @props
    return if e.target.value is ''
    value = parseInt(e.target.value)
    return editor.setWidgetEditorProp(id, value)


  render: ->
    {editor} = @props
    console.log @props
    getProps = (id) =>
      id: id
      editor: editor
      increment: @increment
      decrement: @decrement
      onChange: @handleChange

    div className: 'content', ->
      crel WidgetBackgroundColorPicker
      crel WidgetFontColorPicker
      div className: 'widget-props row middle between', ->
        text 'Border Radius'
        crel WidgetProp, getProps('borderRadius')
      div className: 'widget-props row middle between', ->
        text 'Card Depth'
        crel WidgetProp, getProps('cardDepth')
      br()


BaseWidgetProperties = (props) ->
  div className: 'properties-section', ->
    div className: 'title-row', ->
      crel BaseWidgetPropertiesTitleButton
    crel BaseWidgetPropertiesContent, props




module.exports = BaseWidgetProperties