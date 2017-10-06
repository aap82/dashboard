import React from 'react'
import {extendObservable, computed, expr} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br, ul, li,h5, h6,input,span  } from 'teact'
import {inject, observer} from 'mobx-react'
import { Button, Intent, Checkbox, Tooltip,Position} from  '@blueprintjs/core'
import cx from 'classnames'



ButtonDisplayer = observer(({editor, device, onClick})->
  isSelected = expr(-> editor.device is device)
  labelClassName = cx(
    "pt-menu-item": yes
    "pt-icon-mobile-phone": yes
    "pt-active": isSelected
    "pt-intent-primary": isSelected
#    "pt-disabled": panel.isOpen
  )
#  textClass = cx("pt-disabled": panel.isOpen)
  button type: 'button',
    className: labelClassName
#    disabled: panel.isOpen && !device.isSelected
    onClick: onClick, ->
      h6 "#{device.name}"

)




UserDeviceItem = observer(class UserDeviceItem extends React.Component
  render: ->
    {device, editor} = @props
    li className: 'row middle', =>
      crel ButtonDisplayer,
        device: device
        editor: editor
        onClick: @selectDevice

  selectDevice: =>
    {device, editor} = @props
    editor.selectDevice(device)

)
UserDeviceList = inject('app', 'editor', 'panel')(observer(({app, editor}) =>
  div ->
    app.devices.map (device) =>
      crel UserDeviceItem,
        key: "#{device.ip}"
        device: device
        editor: editor
      li className: 'pt-menu-header'

))


export default UserDeviceList



