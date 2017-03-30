import Editor from '../../stores/editorStore'

export defaultBinding = ->
  (({$try, field, props}) =>
    id: $try(props.id, field.id)
    className: $try(props.className, field.className)
    placeholder: $try(props.placeholder, field.placeholder)
    label: $try(props.placeholder, field.label)
    type: $try(props.type, field.type)
    value: $try(props.value, field.value)
    disabled: $try(props.disabled, !Editor.isEditing)
    onChange: $try(props.onChange, field.onChange)
    onBlur: $try(props.onBlur, field.onBlur)
    onFocus: $try(props.onFocus,field.onFocus)
  )


