React = require 'react'
{crel, div, br, text, input} = require 'teact'
{ observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')
{WidgetBackgroundColorPicker, WidgetFontColorPicker} = require './ColorPicker'
ButtonContainer = require '../components/ButtonContainer'

WidgetProp = observer(({id, editor, widgetProps, button1, button2}) =>
  div className: 'col-xs-6 number-input-container', =>
    div className: 'row middle end', ->
      div className: 'input-section', =>
        input
          id: id
          className: 'pt-input pt-rtl number-input'
          value: widgetProps[id]
          type: 'text'
          onChange: -> return
          disabled: !editor.isEditing
          autoFocus: yes
      crel ButtonContainer, button: button1
      crel ButtonContainer, button: button2

)

WidgetProp.displayName = 'WidgetProp'

class BaseWidgetPropertiesContent extends React.Component
  setColorProps: =>
    console.log 'hi'
  render: ->
    {editorView} = @props
    {widgetProps} = editorView
    {color, backgroundColor, backgroundAlpha} = widgetProps
    {isEditing} = editorView
    {INC_BORDER_RADIUS,DEC_BORDER_RADIUS,INC_CARD_DEPTH, DEC_CARD_DEPTH } = editorView.buttons
    getProps = (id, button1, button2) ->
      id: id
      editor: editorView
      widgetProps: widgetProps
      button1: button1
      button2: button2
    div className: 'properties-section', =>
      div className: 'title-row', ->
        crel Button,
          text: 'Base Widget Properties'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div className: 'content', =>
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