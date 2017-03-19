React = require 'react'
{crel, div, br, text, input} = require 'teact'
{ inject, observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')
MenuButton = require './../components/MenuButton'
ColorPickerComponent = require './ColorPicker'
t = require './buttons/types'


WidgetProp = observer(({id, editor, dashboard, button1, button2, onClick}) =>
  div className: 'col-xs-6 number-input-container', ->
    div className: 'row middle end', ->
      div className: 'input-section', ->
        input
          id: id
          className: 'pt-input pt-rtl number-input'
          value: dashboard[id]
          type: 'text'
          onChange: -> return
          disabled: !editor.isEditing
          autoFocus: yes
      crel MenuButton, buttons: [button1], editor: editor, onClick: onClick
      crel MenuButton, buttons: [button2], editor: editor, onClick: onClick

)

WidgetProp.displayName = 'WidgetProp'
class BaseWidgetPropertiesContent extends React.Component
  render: ->
    {editor} = @props
    {isEditing, dashboard} = editor
    {INC_BORDER_RADIUS,DEC_BORDER_RADIUS,INC_CARD_DEPTH, ADD_NEW_WIDGET, DEC_CARD_DEPTH } = editor.buttons
    getProps = (id, button1, button2) =>
      id: id
      editor: editor
      dashboard: dashboard
      button1: button1
      button2: button2
      onClick: @handleClick
    div className: 'properties-section', =>
      div className: 'title-row', ->
        crel Button,
          text: 'Widgets'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div className: 'content', =>
        crel MenuButton, buttons: [ADD_NEW_WIDGET], editor: editor, onClick: @handleClick
        br()
        div style: {marginRight: -10}, =>
          crel ColorPickerComponent,
            picker: dashboard,
            target: 'widgetBackgroundColor',
            alpha: yes,
            alphaTarget: 'widgetBackgroundAlpha',
            isEditing: isEditing,
            label: 'Background Color'
        div style: {marginRight: -10}, =>
          crel ColorPickerComponent,
            picker: dashboard,
            target: 'widgetFontColor',
            alpha: false,
            isEditing: isEditing,
            label: 'Background Color'


        div className: 'widget-props row middle between', =>
          text 'Border Radius'
          crel WidgetProp, getProps('widgetBorderRadius', INC_BORDER_RADIUS, DEC_BORDER_RADIUS)
        div className: 'widget-props row middle between', ->
          text 'Card Depth'
          crel WidgetProp, getProps('widgetCardDepth', INC_CARD_DEPTH, DEC_CARD_DEPTH)
        br()



  handleClick: (e) =>
    {editor} = @props
    {dashboard} = editor
    switch e.currentTarget.id
      when t.ADD_NEW_WIDGET
        if editor.isEditing then @props.modal.open('addWidget')
        break
      when t.INC_CARD_DEPTH
        break if dashboard.widgetCardDepth is 5
        value = dashboard.widgetCardDepth
        value++
        dashboard.widgetCardDepth = value
        break
      when t.DEC_CARD_DEPTH
        break if dashboard.widgetCardDepth is 0
        value = dashboard.widgetCardDepth
        value--
        dashboard.widgetCardDepth = value
        break
      when t.INC_BORDER_RADIUS
        value = dashboard.widgetBorderRadius
        value++
        dashboard.widgetBorderRadius = value
        break
      when t.DEC_BORDER_RADIUS
        break if dashboard.widgetBorderRadius is 0
        value = dashboard.widgetBorderRadius
        value--
        dashboard.widgetBorderRadius = value
        break







module.exports = inject('modal')(observer(BaseWidgetPropertiesContent))