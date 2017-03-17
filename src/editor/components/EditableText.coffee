React = require 'react'
{extendObservable} = require 'mobx'
{crel } = require 'teact'
{observer} = require 'mobx-react'
{Intent, EditableText} = require('@blueprintjs/core')

class DecoratedEditableText extends React.Component
  constructor: (props) ->
    extendObservable @, {
      isEditing: no
      newText: props.text
      value: props.text
    }

  handleSave: =>
    @props.onSave(@props.id, @newText)
    @isEditing = no

  handleChange: (value) =>
    @newText = value

  makeEditable: =>
    @isEditing = yes

  handleCancel: =>
    @newText = @props.text
    @isEditing = no

  render: ->
    {type} = @props
    crel type, onDoubleClick: @makeEditable, =>
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


module.exports = observer(DecoratedEditableText)