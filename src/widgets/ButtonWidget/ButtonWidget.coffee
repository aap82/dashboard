{crel, div, h4} = require 'teact'
React = require 'react'
Tappable = require 'react-tappable/lib/Tappable'
{observer} = require 'mobx-react'


class ButtonWidget extends React.Component
  handleTapEvent: => @props.device.sendCommand('buttonPressed')

  render: ->
    {widget, device} = @props
    console.log device
    crel Tappable, onTap: @handleTapEvent, =>
      div className: 'widget center', =>
          h4 widget.label




module.exports = observer(ButtonWidget)
