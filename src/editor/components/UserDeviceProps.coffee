React = require 'react'
{observable, toJS} = require 'mobx'
{crel, div, span, h3, h4, h5, text, input, select, br } = require 'teact'
{observer} = require 'mobx-react'
EditableText = require './EditableText'


class UserDeviceProps extends React.Component
  constructor: (props) ->

  handleSave: (id, value) =>
    {editor} = @props
    ip = editor.device.get('ip')
    editor.fetch('opName', 'UpdateUserDevice', {ip: ip, device: {"#{id}": value}}).then (res) =>
      if res.data.updateUserDevice?
        {record} = res.data.updateUserDevice
        editor.updateDevice(record)
      else
        return

  render: ->
    {editor} = @props
    div className: 'title-editor', =>
      div style: {marginBottom: 15}, className: 'content', =>
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
          div 'Device Type'
          div editor.device.get('type')
        div className: 'row center between middle', =>
          div 'IP Address'
          div editor.device.get('ip')
        div className: 'row center between middle', =>
          div 'Device Height'
          div editor.device.get('height') + 'px'
        div className: 'row center between middle', =>
          div 'Device Width'
          div editor.device.get('width') + 'px'

module.exports = (observer(UserDeviceProps))

