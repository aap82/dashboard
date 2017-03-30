import React from 'react'
import {crel, div, input, label, select, option, text} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'

export default SelectInput = observer(({
  field
  options = null
  fill    = no
  inline  = no
  showLabel   = no
  large   = no
  minimal = no
  labelClassName = ''
  selectClassName = ''
}) ->
  labelClass = cx(
    'pt-label',
    'pt-large': large,
    'pt-inline': inline,
    labelClassName
  )
  selectClass = cx(
    'pt-select',
    'pt-large': large,
    'pt-minimal': minimal,
    'pt-fill': fill,
    selectClassName
  )
  dropdown = ->
    div className: selectClass, ->
      select field.bind(), ->
        for item in field.options
          option key: item.value, value: item.value, "#{item.label}"
        if options?
          option key: opt.value, value: opt.value, "#{opt.label}" for opt in options

  if showLabel
    label className: labelClass, htmlFor: field.id, ->
      text "#{field.label}"
      dropdown()
  else
    dropdown()



)


SelectInput.displayName = 'SelectInput'