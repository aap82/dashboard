import {div, label, input, span} from 'teact'
import {observer} from 'mobx-react'

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
export default ToggleSwitch