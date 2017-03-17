{div, label, input, span} = require 'teact'
{observer} = require 'mobx-react'

ToggleSwitch = observer(({state, attr}) =>
  div className: 'card', ->
    label ->
      input
        readOnly: yes
        type: 'checkbox'
        checked: state[attr]
      span className: 'switch'
      span className: 'toggle'
)


ToggleSwitch.displayName = 'ToggleSwitch'
module.exports = ToggleSwitch