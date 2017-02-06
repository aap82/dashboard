{crel, div, h4} = require 'teact'
React = require 'react'
Toggle = require '../components/Toggle'
Tappable = require 'react-tappable/lib/Tappable'
{sendCommand} = require('../actions')
{observer} = require 'mobx-react'



class SwitchWidget extends React.Component
  handleTapEvent: =>
    {platform, deviceId} = @props.device
    sendCommand(platform, deviceId, 'toggle')
    return
  render: ->
    attrNames = if typeof @props.attrNames is  'string' then JSON.parse(@props.attrNames) else @props.attrNames
    console.log attrNames['on']
    crel Tappable, onTap: @handleTapEvent, =>
      div className: 'widget switch-widget center', =>
        div className: 'title-container center middle',=>
          h4 @props.label
        div className: 'switch-container center middle', =>
          crel Toggle, state: @props.state.get(attrNames.on)




module.exports = observer(SwitchWidget)
