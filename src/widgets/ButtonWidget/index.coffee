import {crel, div, h4} from 'teact'
import React from 'react'
import Tappable from 'react-tappable/lib/Tappable'
import {observer} from 'mobx-react'


class ButtonWidget extends React.Component
  handleTapEvent: => @props.device.sendCommand('buttonPressed')

  render: ->
    {widget, device} = @props
    console.log device
    crel Tappable, onTap: @handleTapEvent, =>
      div className: 'widget center', =>
          h4 widget.label




export default observer(ButtonWidget)
