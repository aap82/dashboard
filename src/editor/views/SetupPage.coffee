{crel, div, h2, h3, br} = require 'teact'
{inject, observer} = require 'mobx-react'
React = require 'react'
#SelectDashboardDropDown = require '../components/SelectDashboardDropDown'
{ Button, Intent} = require('@blueprintjs/core')
CreateNewDashboard = require '../components/CreateNewDashboard'

class SetupPage extends React.Component
  constructor: (props) ->
    super props


  render: ->
    {viewStore} = @props
    div className: 'pt-dark setup-page col-xs-12', =>
      div className: 'col-xs-offset-1 col-xs-3', =>
        h2 'Select Dashboard'
        br()
        div className: 'pt-control-group pt-fill', =>
          #crel SelectDashboardDropDown, viewState: viewState
          #crel LoadDashboard, viewState: viewState, onClick: @handleLoadDashboard
        br()
        h2 'or'
        br()
        crel Button,
          intent: Intent.SUCCESS
          className: 'create-new-dashboard-button pt-large'
          iconName: 'grid-view'
          text: 'Create New Dashboard'
          onClick: @handleAddNewDashboard

  handleLoadDashboard: =>
    @props.viewStore.showEditorPage()

  handleAddNewDashboard: =>
    @props.modal.open('addDashboard')


module.exports = inject('viewState', 'modal')(observer(SetupPage))
