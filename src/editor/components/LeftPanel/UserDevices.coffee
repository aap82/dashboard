import React from 'react'
import {extendObservable, computed} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br, ul, li,h5, h6,input,span  } from 'teact'
import {inject, observer} from 'mobx-react'
import { Button, Intent, Checkbox, Tooltip,Position} from  '@blueprintjs/core'
import cx from 'classnames'



ButtonDisplayer = observer(({device, onClick})->
  labelClassName = cx(
    "pt-menu-item": yes
    "pt-icon-layout-grid": yes
    "pt-active": device.isSelected
    "pt-intent-primary": device.isSelected
#    "pt-disabled": panel.isOpen
  )
#  textClass = cx("pt-disabled": panel.isOpen)
  button type: 'button',
    className: labelClassName
#    disabled: panel.isOpen && !device.isSelected
    onClick: onClick, ->
      h6 "#{device.name}"

)




class UserDeviceItem extends React.Component
  render: ->
    {device, panel} = @props
    li className: 'row', =>
      crel ButtonDisplayer,
        device: device
        panel: panel
        onClick: @selectDevice

  selectDevice: =>
    {device, app} = @props
    return if app.device?.ip is device.ip
    app.selectDevice(device)




UserDeviceItem = observer(UserDeviceItem)
UserDeviceList = inject('app', 'panel')(observer(({app, panel}) =>
  div ->
    app.devices.map (device) =>
      crel UserDeviceItem,
        key: "#{device.ip}"
        device: device
        app: app
        panel: panel
      li className: 'pt-menu-header'

))


export default UserDeviceList



