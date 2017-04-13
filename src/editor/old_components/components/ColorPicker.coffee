import React from 'react'
import {crel, div, span, text} from 'teact'
import { observer} from 'mobx-react'
import ColorPicker from 'rc-color-picker'
import Editor from '../../new_stores/Editor'
import cx from 'classnames'


export colorPickerBindings =
  (({$try, field, props}) =>
    id: $try(props.id, field.id)
    className: $try(props.className, field.className)
    placeholder: $try(props.placeholder, field.placeholder)
    label: $try(props.placeholder, field.label)
    disabled: $try(props.disabled, field.disabled)
    mode:  $try(props.mode, field.mode)
    defaultColor: $try(props.defaultColor, field.value.color)
    align: $try(props.align, field.align)
    color: $try(props.color, field.value.color)
    alpha: $try(props.alpha, field.value.alpha)
    onChange: $try(props.onChange, field.onChange)
    onBlur: $try(props.onBlur, field.onBlur)
    onFocus: $try(props.onFocus,field.onFocus)
  )

export default ColorPickerInput = observer(({
  field
  mode='HSL'
}) ->
  className = cx(
    'row between middle': yes
    'color-picker-disabled': field.disabled
  )
  div className: 'column', ->
    div style: {paddingBottom: 5}, ->
      text "#{field.label}"
    div className: className, ->
      text "#{field.value.color}"
      crel ColorPicker,
        field.bind({
          align:
            points: ['br', 'tl']
            offset: [0, 0]
          mode: mode
        }),
        =>
          span className: 'rc-color-picker-trigger'

)


