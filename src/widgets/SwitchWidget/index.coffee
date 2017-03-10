{crel, div, h4} = require 'teact'
React = require 'react'
Toggle = require '../components/Toggle'
Tappable = require 'react-tappable/lib/Tappable'
{observer} = require 'mobx-react'



class SwitchWidget extends React.Component
  render: ->
    {props, state} = @props
    crel Tappable, onTap: @sendCommand, =>
      div className: 'widget switch-widget center', =>
        div className: 'title-container center middle',=>
          h4 props.label
        div className: 'switch-container center middle', =>
          crel Toggle, state: state.get(props.attrNames.on)

  sendCommand: =>
    console.log 'hi'
    @props.sendCommand('toggle')


module.exports = observer(SwitchWidget)
