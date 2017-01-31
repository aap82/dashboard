{div, label, input, span} = require 'teact'
{observer} = require 'mobx-react'


ToggleSwitch = observer(({device}) =>
  div className: 'card', ->
    label ->
      input
        type: 'checkbox'
        id: device.id
        checked: device.attributes.get('state')
        onChange: -> return
      span className: 'switch'
      span className: 'toggle'
)

module.exports = ToggleSwitch