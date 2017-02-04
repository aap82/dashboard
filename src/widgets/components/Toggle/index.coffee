{div, label, input, span} = require 'teact'
{observer} = require 'mobx-react'


ToggleSwitch = observer(({state}) =>
  div className: 'card', ->
    label ->
      input
        type: 'checkbox'
        checked: state.on
        onChange: -> return
      span className: 'switch'
      span className: 'toggle'
)

module.exports = ToggleSwitch