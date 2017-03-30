import React from 'react'
import {crel, div, input, label, text} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'

export default TextInput = observer(({
  field
  fill    = no
  inline  = no
  showLabel   = no
  large   = no
  minimal = no
  labelClassName = ''
  inputClassName = ''
}) ->
  labelClass = cx(
    'pt-label',
    'pt-large': large,
    'pt-inline': inline,
    labelClassName
  )
  inputClass = cx(
    'pt-input',
    'pt-large': large,
    'pt-minimal': minimal,
    'pt-fill': fill,
    inputClassName
  )
  inputForm = ->
    input field.bind({type: 'text', className: inputClass})

  if showLabel
    label className: labelClass, ->
      text "#{field.label}"
      inputForm()
  else
    inputForm()



)


TextInput.displayName = 'TextInput'