{crel, div, h4} = require 'teact'
React = require 'react'
Toggle = require '../components/Toggle'
Tappable = require 'react-tappable/lib/Tappable'
{sendCommand} = require('../actions')
{observer} = require 'mobx-react'
class SwitchWidget extends React.Component
  handleTapEvent: =>
    {device} = @props
    {platform, deviceId} = device
    sendCommand(platform, deviceId, 'toggle')
    return
  render: ->
    {widget, device} = @props
    console.log widget
    crel Tappable, onTap: @handleTapEvent, =>
      div className: 'widget switch-widget center', =>
        div className: 'title-container center middle', ->
          h4 widget.label
        div className: 'switch-container center middle', =>
          crel Toggle, state: device.state




module.exports = observer(SwitchWidget)
