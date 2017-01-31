{crel, div, h2, h3, br} = require 'teact'
{inject, observer} = require 'mobx-react'
React = require 'react'
SelectDashboardDropDown = require './components/SelectDashboardDropDown'
{ Button, Intent} = require('@blueprintjs/core')
CreateNewDashboard = require './components/CreateNewDashboard'
LoadDashboard = observer(({viewStore, onClick}) =>
  crel Button,
    disabled: viewStore.selectedDashboardId is 0
    className: 'pt-large'
    iconName: 'pt-icon-dashboard',
    intent: Intent.PRIMARY,
    onClick: onClick
    text: 'Load'

)





class SetupPage extends React.Component

  render: ->
    {viewStore} = @props
    div className: 'pt-dark setup-page col-xs-12', =>
      div className: 'col-xs-offset-1 col-xs-3', =>
        h2 'Select Dashboard'
        br()
        div className: 'pt-control-group pt-fill', =>
          crel SelectDashboardDropDown, viewStore: viewStore
          crel LoadDashboard, viewStore: viewStore, onClick: @handleLoadDashboard
        br()
        h2 'OR'
        br()
        crel CreateNewDashboard, viewStore: viewStore
  handleLoadDashboard: =>
    {selectedDashboardId} = @props.viewStore
    @props.editor.loadDashboard(selectedDashboardId)
    @props.viewStore.showEditorPage()


module.exports = inject('viewStore', 'editor')(observer(SetupPage))
