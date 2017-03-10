{crel, div} = require 'teact'
React = require 'react'
{getWidget} = require './getWidget'
{inject, observer} = require 'mobx-react'
{sendCommand} = require('./actions')

class WidgetContainer extends React.Component
  render: ->
    {props, style, device, state} = @props
    Widget = getWidget(props.type)
    div style: style, className: 'base-widget z-depth-' + props.cardDepth, =>
      crel Widget,
        props: props
        state: state
        device: device
        sendCommand: @sendDeviceCommand


  sendDeviceCommand: (command) =>
    console.log command
    {platform, deviceId} = @props.device
    sendCommand(platform, deviceId, command)
    return




module.exports = inject((stores, {device}) => ({
  state: stores.states[device.id]
}))(observer(WidgetContainer))