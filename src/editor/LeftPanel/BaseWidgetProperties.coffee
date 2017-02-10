React = require 'react'
{crel, div, br, text, input} = require 'teact'
{ observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')
{WidgetBackgroundColorPicker, WidgetFontColorPicker} = require './ColorPicker'
ButtonContainer = require '../components/ButtonContainer'

WidgetProp = observer(({id, editor, onChange, button1, button2}) =>
  div className: 'col-xs-6 number-input-container', =>
    div className: 'row middle end', ->
      div className: 'input-section', =>
        input
          id: id
          className: 'pt-input pt-rtl number-input'
          value: editor.widgetProps[id]
          type: 'text'
          onChange: onChange
          disabled: !editor.isEditing
          autoFocus: yes
      crel ButtonContainer, button: button1
      crel ButtonContainer, button: button2

)

WidgetProp.displayName = 'WidgetProp'

class BaseWidgetPropertiesContent extends React.Component
  increment: (e) =>
    console.log e.target.id
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
    {INC_BORDER_RADIUS,DEC_BORDER_RADIUS,INC_CARD_DEPTH, DEC_CARD_DEPTH } = editor.buttons
    getProps = (id, button1, button2) ->
      id: id
      editor: editor
      button1: button1
      button2: button2
      onChange: @handleChange
    div className: 'properties-section', ->
      div className: 'title-row', ->
        crel Button,
          text: 'Base Widget Properties'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div className: 'content', ->
        crel WidgetBackgroundColorPicker
        crel WidgetFontColorPicker
        div className: 'widget-props row middle between', ->
          text 'Border Radius'
          crel WidgetProp, getProps('borderRadius', INC_BORDER_RADIUS, DEC_BORDER_RADIUS)
        div className: 'widget-props row middle between', ->
          text 'Card Depth'
          crel WidgetProp, getProps('cardDepth', INC_CARD_DEPTH, DEC_CARD_DEPTH)
        br()




module.exports = BaseWidgetPropertiesContent