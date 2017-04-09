import React from 'react'
import {crel, div, input, h3, label, select, option, text,span} from 'teact'
import {inject, observer} from 'mobx-react'
import {Tooltip, EditableText, Intent} from '@blueprintjs/core'
import {extendObservable} from 'mobx'

export default EditableTextInput = observer(class EditableTextInput extends React.Component
  constructor: (props) ->
    super props
    @oldText = props.value
    extendObservable @, { newText: props.value    }
  componentWillReceiveProps: (nextProps) =>
    if nextProps.value isnt @newText
      @oldText = nextProps.value
      @newText = nextProps.value
  render: ->
    {element} = @props
    crel "#{element}", =>
      crel EditableText,
        confirmOnEnterKey: yes
        intent: Intent.PRIMARY
        placeholder: @oldText
        value: @newText
        minWidth: 20
        selectAllOnFocus: yes
        onCancel: @handleCancel
        onChange: @handleChange
        onConfirm: @handleConfirm

  handleConfirm: =>
    return if @newText is @oldText
    @handleCancel() if @newText is ''
    @props.onConfirm(@newText)

  handleChange: (value) => @newText = value
  handleCancel: => @newText = @oldText

)




