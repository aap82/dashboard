import Editor from '../../stores/editorStore'

export dashboard = (opts = {}) ->
  (({$try, field, props}) =>
    id: $try(props.id, field.id)
    className: $try(props.className, field.className)
    placeholder: $try(props.placeholder, field.placeholder)
    value: $try(props.value, field.value)
    disabled: $try(props.disabled, !Editor.isEditing)
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


