{crel, div, h2, select, option, br} = require 'teact'
{inject, observer} = require 'mobx-react'
React = require 'react'
{ Button, Intent} = require('@blueprintjs/core')


LoadUserDevice = observer(({viewState, onClick}) =>
  crel Button,
    disabled: viewState.selectedUserDevice is ''
    className: 'pt-large'
    iconName: 'pt-icon-dashboard',
    intent: Intent.PRIMARY,
    onClick: onClick
    text: 'Load'

)

UserDeviceDropDownListView = (observer(({viewState, editor, onChange}) ->
  displayName: 'SelectUserDeviceDropDown'
  div className: 'pt-select pt-fill pt-large', ->
    select value: viewState.selectedUserDevice, onChange: onChange, ->
      option value: 0, 'Select User Device...'
      editor.userDevices.values().map (userDevice) ->
        option key: userDevice.get('ip'), value: userDevice.get('ip'), "#{userDevice.get('name')}" #" / #{dashboard.deviceType}"
))


class SetupPage extends React.Component
  constructor: (props) ->
    super props


  render: ->
    {viewState} = @props
    {editor} = viewState
    div className: 'pt-dark setup-page col-xs-12', =>
      div className: 'col-xs-offset-1 col-xs-3', =>
        h2 'Select Device'
        br()
        div className: 'pt-control-group', =>
          crel UserDeviceDropDownListView, viewState: viewState, editor: editor, onChange: @handleUserDeviceChange
          crel LoadUserDevice, viewState: viewState, onClick: @handleLoadUserDevice

  handleLoadUserDevice: =>
    @props.viewState.loadUserDevice()


  handleUserDeviceChange: (e) => @props.viewState.setUserDevice(e.target.value)


module.exports = inject('viewState', 'modal')(observer(SetupPage))
