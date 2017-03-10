{div, label, input, span} = require 'teact'
{observer} = require 'mobx-react'

ToggleSwitch = observer((props) =>
  div className: 'card', ->
    label ->
      input
        type: 'checkbox'
        checked: props.state
        onChange: -> return
      span className: 'switch'
      span className: 'toggle'
)


ToggleSwitch.displayName = 'ToggleSwitch'
module.exports = ToggleSwitch