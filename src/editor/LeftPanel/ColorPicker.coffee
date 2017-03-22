import React from 'react'
import {crel, div, span, text} from 'teact'
import { observer} from 'mobx-react'
import ColorPicker from 'rc-color-picker'


class ColorPickerComponent  extends React.Component
  handleChange: (colors) =>
    {picker, target, alpha, alphaTarget} = @props
    picker[target] = colors.color
    if alpha? then picker[alphaTarget] = colors.alpha
    return
  render: ->
    {picker, target, isEditing, alphaTarget} = @props
    div className: 'color-picker-row widget-color-picker-row', =>
      text "#{@props.label}"
      crel ColorPickerContainer,
        picker: picker,
        target: target,
        alphaTarget: alphaTarget,
        isEditing: isEditing,
        onChange: @handleChange



ColorPickerContainer = observer(({isEditing, picker, target, alphaTarget, onChange}) ->
  className = if !isEditing then 'color-picker-disabled' else ''
  div className: 'color-picker-text', ->
    text "#{picker[target]}"
    div style: {
        margin: '15px 15px 15px',
        textAlign: 'center'
    }, className: className, ->
      crel ColorPicker,
        color: picker[target]
        alpha: picker[alphaTarget] or 100
        mode: 'HSL'
        align:
          points: ['br', 'tl']
          offset: [0, 0]
        onChange: onChange, =>
          span className: 'rc-color-picker-trigger'

)



export default observer(ColorPickerComponent)