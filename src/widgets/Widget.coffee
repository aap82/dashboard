import {crel, div} from 'teact'
import React from 'react'
import {getWidget} from './getWidget'
import {inject, observer} from 'mobx-react'
import {toJS} from 'mobx'
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

  @getState: =>
    console.log toJS(@props.state)





WidgetContainer = inject(({deviceStore}, {device}) => ({
  state: deviceStore.states.get(device.id)
}))(observer(WidgetContainer))


export default WidgetContainer