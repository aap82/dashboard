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




class WidgetStyleEditor extends React.Component



  render: ->
    {editor} = @props

    div style: {paddingLeft: 5, paddingRight: 5, paddingTop: 10}, className: 'content', =>
      div style: {marginBottom: 10}, className: 'row between middle', =>
        div 'Border Radius'


      div style: {marginBottom: 10}, className: 'row between middle', =>
        div 'Card Depth'

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
