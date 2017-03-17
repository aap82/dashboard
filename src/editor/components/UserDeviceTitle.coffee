React = require 'react'
{observable, toJS} = require 'mobx'
{crel, div, span, h3, h4, h5, text, input, select, br } = require 'teact'
{observer} = require 'mobx-react'
EditableText = require './EditableText'


class UserDeviceName extends React.Component
  constructor: (props) ->
    @device = toJS(props.editor.device)
    console.log @device

  handleSave: (id, value) =>
    {editor} = @props
    editor.fetch('opName', 'UpdateUserDevice', {ip: @device.ip, device: {"#{id}": value}}).then (res) =>
      if res.data.updateUserDevice?
        {record} = res.data.updateUserDevice
        editor.updateDevice(record)
      else
        return

  render: ->
    {editor} = @props
    div className: 'title-editor', =>
      div className: 'content', =>
        div style: {marginBottom: 8}, className: 'row center between middle', =>
          h5 'User Device'
          crel EditableText,
            id: 'name'
            type: 'h4'
            text: editor.device.get('name')
            onSave: @handleSave
        div className: 'row between middle', =>
          div 'Location'
          crel EditableText,
            id: 'location'
            type: 'div'
            text: editor.device.get('location')
            onSave: @handleSave
        div className: 'row center between middle', =>
          div 'IP Address'
          div @device.ip
        div className: 'row center between middle', =>
          div 'Device Height'
          div @device.height + 'px'
        div className: 'row center between middle', =>
          div 'Device Width'
          div @device.width + 'px'

module.exports = (observer(UserDeviceName))

