import {crel, label, div, h2, select, option, br, code, text} from 'teact'
import {inject, observer} from 'mobx-react'
import React from 'react'
import { Button, Intent} from  '@blueprintjs/core'
import Select from '../forms/components/Select'
import CheckBox from '../forms/components/CheckBox'


LoadUserDeviceButton = observer(({field, onClick}) =>
  crel Button,
    disabled: field.value is ''
    className: 'pt-large'
    intent: Intent.PRIMARY,
    onClick: onClick
    text: 'Load'

)

SelectForm = observer(({ userDevices, form }) =>
  devices = ({value: device.get('ip'), label: device.get('name')} for device in userDevices.values())
  div className: 'pt-control-group', ->
    crel Select,
      showLabel: no
      large: yes
      fill: yes
      inline: yes
      field: form.$('selectDevice')
      options: devices,
    crel LoadUserDeviceButton,
      field: form.$('selectDevice')
      onClick: form.onSubmit


)




LoadUserDevice =({onClick}) =>
  crel Button,
    className: 'pt-large'
    iconName: 'pt-icon-dashboard',
    intent: Intent.PRIMARY,
    onClick: onClick
    text: 'Load'





class SetupPage extends React.Component
  constructor: (props) ->
    super props


  render: ->
    {forms, userDevices} = @props
    div className: 'pt-dark setup-page col-xs-12', =>
      div className: 'col-xs-offset-1 col-xs-3', =>
        br()
        h2 'Select Device'
        crel SelectForm, form: forms.selectDevice, userDevices: userDevices.devices
        br()
        br()
        crel LoadUserDevice, onClick: @handleClick



  handleClick: =>
    @props.forms.selectDevice.testDashboard()


SetupPage = inject('userDevices', 'forms')(observer(SetupPage))
export default SetupPage
