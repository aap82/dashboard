import React from 'react'
import {crel, div, input, label, text} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import Editor from '../../new_stores/Editor'
import { NumericInput,Intent,Position } from "@blueprintjs/core"

export numberInputBindings =
  (({$try, field, props}) =>
    id: $try(props.id, field.id)
    className: $try(props.className, field.className)
    placeholder: $try(props.placeholder, field.placeholder)
    label: $try(props.placeholder, field.label)
    type: $try(props.type, field.type)
    value: $try(props.value, field.value)
    disabled: $try(props.disabled, !Editor.isEditing)
    onValueChange: $try(props.onChange, field.onChange)
    onBlur: $try(props.onBlur, field.onBlur)
    onFocus: $try(props.onFocus,field.onFocus)
    min: $try(props.min,field.min)
    max: $try(props.max,field.max)
    minorStepSize: $try(props.minorStepSize,field.minorStepSize)
    majorStepSize: $try(props.majorStepSize,field.majorStepSize)
    buttonPosition: $try(Position[field.buttonPosition],Position.RIGHT)
    intent: $try(props.intent,field.intent)




  )


export default NumberInput = observer(({
  field
  showLabel = no
  fill    = no
  inline  = no
  large   = no
  minimal = no
  className = ''
  intent='PRIMARY'
  leftIconName=''
  min=1
  max=100
  minorStepSize=1
  majorStepSize=3

}) ->
  containerClass = cx(
    'pt-large': large,
    'pt-minimal': minimal,
    'pt-fill': fill,
  )
  props = field.bind({
    intent: Intent[intent]
    min: min
    max: max
    minorStepSize: minorStepSize
  })
  console.log props
  if showLabel
    div className: containerClass, ->
      div style: paddingBottom: 5, ->
        label "#{field.label}"
      crel NumericInput, props
  else
    div className: containerClass, ->
      crel NumericInput, props






)


NumberInput.displayName = 'NumberInput'