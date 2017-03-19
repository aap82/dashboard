{crel, div} = require 'teact'
React = require 'react'
{getWidget} = require './getWidget'
{inject, observer} = require 'mobx-react'

class WidgetContainer extends React.Component
  render: ->
    {style, device, state, type} = @props
    Widget = getWidget(type)
    div style: style, className: 'base-widget z-depth-' + @props.cardDepth, =>
      crel Widget,
        label: @props.label
        state: state
        device: device
        sendCommand: @sendDeviceCommand


  sendDeviceCommand: (command) =>
    {platform, deviceId} = @props.device
    @props.sendCommand(platform, deviceId, command)
    return




module.exports = inject((stores, {device}) => ({
  state: stores.deviceStore.states.get(device.id)
}))(observer(WidgetContainer))