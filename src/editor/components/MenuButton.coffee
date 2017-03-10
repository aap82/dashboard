{crel, div, br, text, input} = require 'teact'
{Button} = require('@blueprintjs/core')
{ observer} = require 'mobx-react'
MenuButton = observer(({buttons, onClick}) =>
  button = b for b in buttons when b.isVisible
  div className: button.display, id: button.id, onClick: onClick, =>
    crel Button,
      text: button.text
      className: button.className
      loading: button.loading
      iconName: button.iconName
      disabled: button.disabled
      intent: button.intent
)

module.exports = MenuButton