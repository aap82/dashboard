import {crel, div} from 'teact'
import React from 'react'
import {getWidget} from './getWidget'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'



class WidgetContainer extends React.Component


  render: ->
    {device, state, type} = @props
    className = cx(
      'base-widget z-depth-' + @props.cardDepth,

    )
    Widget = getWidget(type)
    div style: @props.style, className: className, =>
      crel Widget,
        label: @props.label
        state: state
        device: device
        sendCommand: @sendDeviceCommand


  sendDeviceCommand: (command) =>
    {platform, deviceId} = @props.device
    @props.sendCommand(platform, deviceId, command)
    return




export default inject((stores, {device}) => ({
  state: stores.deviceStore.states.get(device.id)
}))(observer(WidgetContainer))