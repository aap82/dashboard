import React from 'react'
import {extendObservable} from 'mobx'
import {crel } from 'teact'
import {observer} from 'mobx-react'
import {Intent, EditableText} from  '@blueprintjs/core'

class DecoratedEditableText extends React.Component
  constructor: (props) ->
    extendObservable @, {
      isEditing: no
      newText: props.text
    }
  handleSave: (e) =>
    e.preventDefault
    @isEditing = no
    if @newText isnt @props.text
      @props.onSave(@props.id, @newText)
  handleChange: (value) =>
    if @props.live then @props.obj[@props.id] = value

    @newText = value

  makeEditable: (e) =>
    e.preventDefault
    @isEditing = yes

  handleCancel: (e) =>
    @newText = @props.text
    @isEditing = no

  handleBlur: (e) =>
    e.preventDefault
    @isEditing = no


  render: ->
    {type} = @props
    crel type, onBlur: @handleBlur, onDoubleClick: @makeEditable, =>
      crel EditableText,
        className: 'pt-rtl pt-fill pt-align-right'
        placeholder: @props.text
        value: @newText
        isEditing: @isEditing
        disabled: !@isEditing
        selectAllOnFocus: yes
        onCancel: @handleCancel
        onChange: @handleChange
        intent: if @isEditing then Intent.SUCCESS else Intent.PRIMARY
        onConfirm: @handleSave


export default observer(DecoratedEditableText)