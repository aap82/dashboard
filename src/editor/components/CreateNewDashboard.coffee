{extendObservable, action,toJS, runInAction} = require 'mobx'
React = require 'react'
{crel, div, text, h4, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Popover, PopoverInteractionKind, Position, Button} = require('@blueprintjs/core')



class CreateNewDashboard extends React.Component
  constructor: (props) ->
    super props
    extendObservable(@, {
      isOpen: no
      open: action(=> @isOpen =yes)
      close: action(=> @isOpen =no)
    })
  render: ->
    {viewState} = @props
    crel Popover,
      position: Position.BOTTOM_LEFT
      interactionKind: PopoverInteractionKind.CLICK
      content: crel(NewDashboardPanel, view: viewState, close: @close)
      useSmartPositioning: no
      isModal: yes
      popoverClassName: 'pt-minimal dashboard-input-container'
      isOpen: @isOpen, =>
        crel Button,
          intent: Intent.SUCCESS
          className: 'create-new-dashboard-button pt-large'
          iconName: 'grid-view'
          text: 'Create New Dashboard'
          onClick: @open



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
        {view} = @props
        {editor, store} = view
        editor.load store.create(toJS(@dashboard))
        @reset()
        view.showEditorPage()

      )
      reset: action(=>
        @props.close()
        @dashboard=
          deviceType: 'tablet'
          title: ''
      )
    })

  render: ->
    div className: 'dashboard-input', =>
      h4 'Create New Dashboard'
      crel TitleInput, dashboard: @dashboard, changeTitle: @changeTitle
      crel DeviceTypeSelect, dashboard: @dashboard, changeType: @changeType
      div className: 'dashboard-input-buttons', =>
        crel Button,
          intent: Intent.SUCCESS
          iconName: 'add'
          text: 'Add'
          onClick: @createDashboard
        crel Button,
          intent: Intent.DANGER
          iconName: 'delete'
          text: 'Cancel'
          onClick: @reset



TitleInput = observer(({dashboard, changeTitle}) ->
  div className: 'title-input', ->
    text 'Title'
    input
      className: 'pt-input pt-rtl pt-dark'
      value: dashboard.title
      onChange: changeTitle
      placeholder: 'Dashboard Title'
      type: 'text'

)

DeviceTypeSelect = observer(({dashboard, changeType}) ->
  div className: 'deviceType-select', ->
    text 'Device Type'
    div className: 'pt-select', ->
      select value: dashboard.device, onChange: changeType, ->
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'
)



module.exports = inject('viewState')(observer(CreateNewDashboard))
