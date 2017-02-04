{crel, div, h4} = require 'teact'
React = require 'react'
Toggle = require '../components/Toggle'
Tappable = require 'react-tappable/lib/Tappable'
{observer} = require 'mobx-react'
class SwitchWidget extends React.Component
  handleTapEvent: => @props.device.sendCommand('toggle')

  render: ->
    console.log @props
    {widget, device} = @props
    crel Tappable, onTap: @handleTapEvent, =>
      div className: 'widget switch-widget center', =>
        div className: 'title-container center middle', ->
          h4 widget.label
        div className: 'switch-container center middle', =>
          crel Toggle, device: device




module.exports = observer(SwitchWidget)
