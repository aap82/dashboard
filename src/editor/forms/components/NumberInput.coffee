import React from 'react'
import {crel, div, input, label, text} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import { NumericInput } from "@blueprintjs/core"


numberInputBindings = (opts = {}) ->
  (({$try, field, props}) =>
    id: $try(props.id, field.id)
    placeholder: $try(props.placeholder, field.placeholder)
    value: $try(props.value, field.value)
    disabled: $try(props.disabled, field.disabled)
    onChange: $try(
      props.onChange,
      if opts.onChange? then opts.onChange(field) else field.onChange
    )
    onBlur: $try(
      props.onBlur,
      if opts.onBlur? then opts.onBlur(field) else field.onBlur
    )
    onFocus: $try(
      props.onFocus,
      if opts.onFocus? then opts.onFocus(field) else field.onFocus
    )

  )

export default NumberInput = observer(({
  field
  fill    = no
  inline  = no
  large   = no
  minimal = no
  className = ''
}) ->




)


NumberInput.displayName = 'NumberInput'