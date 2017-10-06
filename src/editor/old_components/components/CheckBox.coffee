import React from 'react'
import {text, div, input, span, label} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'

export default CheckBox = observer(({
  field
  inline      = no
  fill        = no
  right       = no
  toggle      = yes
  large       = no
  labelClassName = ''
  labelStyle = {}
  inputClassName = ''
}) ->
  labelClass = cx(
    'pt-control',
    'pt-checkbox': !toggle
    'pt-switch': toggle
    'pt-inline': inline
    'pt-large': large,
    'pt-fill': fill,
    'pt-align-right': right,
    labelClassName
  )
  spanClass = cx(
    'pt-control-indicator'
    inputClassName
  )
  props = field.bind({ type: 'checkbox' })
  props.checked = field.value
  label style: labelStyle,
    className: labelClass, htmlFor: field.id, ->
      input type: 'checkbox',
        checked: field.value

      span className: spanClass
      text "#{field.label}"

)


CheckBox.displayName = 'CheckBox'