{crel, div} = require 'teact'
{observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')



ButtonContainer = observer(({button}) ->
  div className: button.display, id: button.id, onClick: button.onClick, ->
    crel Button,
      text: button.text
      className: button.className
      loading: button.loading
      iconName: button.iconName
      disabled: button.disabled
      intent: button.intent
)


module.exports = ButtonContainer