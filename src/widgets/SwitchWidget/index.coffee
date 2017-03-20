{crel, div, text} = require 'teact'
React = require 'react'
Toggle = require '../components/Toggle'
Tappable = require 'react-tappable/lib/Tappable'
{attrNamesMap} = require './props'



class SwitchWidget extends React.Component
  render: ->
    {label, state, device} = @props
    attrNames = attrNamesMap[device.platform]
    crel Tappable, onTap: @sendCommand, =>
      div className: 'widget switch-widget center', =>
        div className: 'title-container center middle',=>
          div className: 'widget-label-primary', label
        div className: 'switch-container center middle', =>
          crel Toggle, state: state, attr: attrNames.on

  sendCommand: => @props.sendCommand('toggle')


module.exports = SwitchWidget
