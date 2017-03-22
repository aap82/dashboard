import {crel, div, br, text, input} from 'teact'
import {Button} from  '@blueprintjs/core'
import { observer} from 'mobx-react'

export default MenuButton = observer(({buttons, onClick}) =>
  button = b for b in buttons when b.isVisible
  if !button? then return null
  div className: button.display, id: button.id, onClick: onClick, =>
    crel Button,
      text: button.text
      className: button.className
      loading: button.loading
      iconName: button.iconName
      disabled: button.disabled
      intent: button.intent
)

