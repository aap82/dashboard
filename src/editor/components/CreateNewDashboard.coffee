{extendObservable, action,toJS, runInAction} = require 'mobx'
React = require 'react'
{crel, div, text, br, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button} = require('@blueprintjs/core')
Tappable = require 'react-tappable/lib/Tappable'

class NewDashboardPanel extends React.Component
  constructor: (props) ->
    super
    @device = props.viewState.editor.devices[0]
    extendObservable(@, {
      dashboard:
        deviceType: 'tablet'
        title: ''
      changeType: action((e) =>
        @device = props.viewState.editor.devices[e.target.value]
        @dashboard.deviceType = @device.ip
      )
      changeTitle: action((e) => @dashboard.title = e.target.value)
      createDashboard: action(=>
        {viewState} = @props
        console.log toJS(@dashboard)
        viewState.editor.create(toJS(@dashboard), @device)
        @props.close()
        @reset()
        viewState.showEditorPage()
      )
      reset: action(=>
        @props.close()
        @device = null
        @dashboard=
          deviceType: ''
          title: ''
      )
    })

  render: ->
    {editor} = @props.viewState
    div className: 'col-xs-12', =>
      br()
      crel TitleInput, dashboard: @dashboard, changeTitle: @changeTitle
      br()
      br()
      crel DeviceTypeSelect, dashboard: @dashboard, editor: editor, changeType: @changeType
      br()
      br()
      div className: 'row around middle', =>
        div =>
          crel Button,
            intent: Intent.SUCCESS
            className: 'pt-large pt-fill'
            iconName: 'add'
            text: 'Add'
            onClick: @createDashboard
        div =>
          crel Button,
            className: 'pt-large pt-fill'
            intent: Intent.DANGER
            iconName: 'delete'
            text: 'Cancel'
            onClick: @reset



TitleInput = observer(({dashboard, changeTitle}) ->
  div className: 'row between middle', ->
    text 'Title'
    input
      className: 'pt-input pt-rtl pt-dark'
      value: dashboard.title
      onChange: changeTitle
      placeholder: 'Dashboard Title'
      type: 'text'

)

DeviceTypeSelect = observer(({dashboard, editor, changeType}) ->
  div className: 'row between middle', ->
    text 'Device Type'
    div className: 'pt-select', ->
      select value: dashboard.device, onChange: changeType, ->
        for device,i in editor.devices
          option key: i, value: i, "#{device.name}"
)



module.exports = inject('viewState')(observer(NewDashboardPanel))
