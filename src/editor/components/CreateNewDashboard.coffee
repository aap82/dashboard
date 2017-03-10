{extendObservable, action,toJS, runInAction} = require 'mobx'
React = require 'react'
{crel, div, text, br, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button} = require('@blueprintjs/core')

class NewDashboardPanel extends React.Component
  constructor: (props) ->
    super
    extendObservable(@, {
      dashboard:
        deviceType: 'tablet'
        title: ''
      changeType: action((e) => @dashboard.deviceType = e.target.value)
      changeTitle: action((e) => @dashboard.title = e.target.value)
      createDashboard: action(=>
        {viewState} = @props
        viewState.editor.create(toJS(@dashboard))
        @props.close()
        @reset()
        viewState.showEditorPage()

      )
      reset: action(=>
        @props.close()
        @dashboard=
          deviceType: 'tablet'
          title: ''
      )
    })

  render: ->
    div className: 'col-xs-12', =>
      br()
      crel TitleInput, dashboard: @dashboard, changeTitle: @changeTitle
      br()
      br()
      crel DeviceTypeSelect, dashboard: @dashboard, changeType: @changeType
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

DeviceTypeSelect = observer(({dashboard, changeType}) ->
  div className: 'row between middle', ->
    text 'Device Type'
    div className: 'pt-select', ->
      select value: dashboard.device, onChange: changeType, ->
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'
)



module.exports = inject('viewState')(observer(NewDashboardPanel))
