{div, label, input, span} = require 'teact'
{observer} = require 'mobx-react'


ToggleSwitch = observer(({device}) =>
  console.log device
  div className: 'card', ->
    label ->
      input
        type: 'checkbox'
        id: device.deviceId
        checked: yes #device.states.state
        onChange: -> return
      span className: 'switch'
      span className: 'toggle'
)

module.exports = ToggleSwitch