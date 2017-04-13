import React from 'react'
import {crel, div, input, label, text} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import { NumericInput,Intent,Position } from "@blueprintjs/core"



NumberInput = observer(({
  value
  onChange
  fill    = yes
  inline  = no
  large   = no
  minimal = no
  className = ''
  intent='NONE'
  leftIconName=''
  min=1
  max=100
  minorStepSize=1
  majorStepSize=10
  buttonPosition='RIGHT'
}) ->
  displayName: 'NumberInput'
  inputClassName = cx(
    'pt-large': large,
    'pt-minimal': minimal,
    'pt-fill': fill,
  )
  props =
    value: value
    intent: Intent[intent]
    min: min
    max: max
    className: inputClassName
    buttonPosition: Position[buttonPosition]
    minorStepSize: minorStepSize
    majorStepSize: majorStepSize
    onValueChange: onChange
  crel NumericInput, props
)



export default NumberInput