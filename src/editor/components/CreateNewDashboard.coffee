React = require 'react'
{crel, div, text, h4, input, select, option, pureComponent,br } = require 'teact'
{inject, observer} = require 'mobx-react'
{Menu, InputGroup, Intent, Popover, PopoverInteractionKind, Position, Button} = require('@blueprintjs/core')




TitleInput = observer(({viewStore, onChange}) ->
  div className: 'title-input', ->
    text 'Title'
    input
      className: 'pt-input pt-rtl pt-dark'
      value: viewStore.newDashboardTitle
      onChange: onChange
      placeholder: 'Dashboard Title'
      type: 'text'

)

DeviceTypeSelect = observer(({viewStore, onChange}) ->
  div className: 'deviceType-select', ->
    text 'Device Type'
    div className: 'pt-select', ->
      select value: viewStore.newDashboardDeviceType, onChange: onChange, ->
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'
)


class NewDashboardPanel extends React.Component
  handleAddButtonPress: => @props.viewStore.createNewDashboard()
  handleCancelButtonPress: => @props.viewStore.closeCreateDashboardPanel()
  onTitleInputChange: (e) => @props.viewStore.changeNewDashboardTitle(e.target.value)
  onDeviceTypeChange: (e) => @props.viewStore.changeNewDashboardDeviceType(e.target.value)


  render: ->
    {viewStore} = @props
    div className: 'dashboard-input', =>
      h4 'Create New Dashboard'
      crel TitleInput, onChange: @onTitleInputChange, viewStore: viewStore
      crel DeviceTypeSelect, onChange: @onDeviceTypeChange, viewStore: viewStore
      div className: 'dashboard-input-buttons', =>
        crel Button,
          intent: Intent.SUCCESS
          iconName: 'add'
          text: 'Add'
          onClick: @handleAddButtonPress
        crel Button,
          intent: Intent.DANGER
          iconName: 'delete'
          text: 'Cancel'
          onClick: @handleCancelButtonPress


class CreateNewDashboard extends React.Component
  handleCreateButtonPress: => @props.viewStore.openCreateDashboardPanel()
  render: ->
    {viewStore} = @props
    crel Popover,
      position: Position.BOTTOM_LEFT
      interactionKind: PopoverInteractionKind.CLICK
      content: crel(NewDashboardPanel, viewStore: viewStore)
      useSmartPositioning: no
      isModal: yes
      popoverClassName: 'pt-minimal dashboard-input-container'
      isOpen: viewStore.isCreateNewDashboardPanelOpen, =>
        crel Button,
          intent: Intent.SUCCESS
          className: 'create-new-dashboard-button pt-large'
          iconName: 'grid-view'
          text: 'Create New Dashboard'
          onClick: @handleCreateButtonPress







module.exports = observer(CreateNewDashboard)
