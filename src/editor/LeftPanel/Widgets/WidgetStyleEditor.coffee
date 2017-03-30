import React from 'react'
import {crel, div, a, h5, h4, text, span, pureComponent,br } from 'teact'
import {inject, observer} from 'mobx-react'

import Color from 'color'
import ColorPicker from 'rc-color-picker'




ColorPickerComponent = observer((props) ->
  div className: 'color-picker-row widget-color-picker-row', =>
    text "#{props.label}"
    div className: 'color-picker-text', ->
      text "#{props.color}"
      div style: {
        margin: '15px 15px 15px',
        textAlign: 'center'
      }, ->
        crel ColorPicker,
          color: props.color
          alpha: props.alpha
          mode: 'HSL'
          align:
            points: ['br', 'tl']
            offset: [0, 0]
          onChange: props.onChange, =>
            span className: 'rc-color-picker-trigger'
)







class WidgetStyleEditor extends React.Component
  handleBackgroundChange: (colors) =>
    {editor} = @props
    backgroundColor = Color(colors.color).alpha(colors.alpha/100).hsl().string()
    for widget, i in editor.editingWidgets
      widget.style.backgroundColor = backgroundColor

  handleFontColorChange: (colors) =>
    {editor} = @props
    for widget, i in editor.editingWidgets
      widget.style.color = colors.color

  render: ->
    {editor} = @props
    div =>
      div style: {marginRight: -18}, =>
        crel ColorPickerComponent,
          label: 'Background Color'
          color: Color(editor.editingWidgets[0].style.backgroundColor).hex()
          alpha: Color(editor.editingWidgets[0].style.backgroundColor).alpha() * 100
          onChange: @handleBackgroundChange
      div style: {marginRight: -18}, =>
        crel ColorPickerComponent,
          label: 'Font Color'
          color: Color(editor.editingWidgets[0].style.color).hex()
          alpha: 100
          onChange: @handleFontColorChange


WidgetStyleEditor = observer(WidgetStyleEditor)


WidgetStyle = observer(({editor}) ->
  overrides = (widget.overrideStyle for widget in editor.editingWidgets when widget.overrideStyle)
  switch
    when overrides.length is editor.editingWidgets.length then crel WidgetStyleEditor, editor: editor
    else return null



)

export default WidgetStyle