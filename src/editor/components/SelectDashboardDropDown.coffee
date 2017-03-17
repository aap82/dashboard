React = require 'react'
{crel, div, text, label, button, select, option, pureComponent,br } = require 'teact'
{inject, observer} = require 'mobx-react'




DeviceTypeDropDown =  ->
  displayName: 'DeviceTypeDropDown'
  label className: 'pt-label', ->
    text 'Type'
    div className: 'pt-select', ->
      select defaultValue: 'all', ->
        option value: 'all', 'All'
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'



DashboardDropDownListView = (observer(({viewStore, onChange}) ->
    displayName: 'SelectDashboardListView'
    div className: 'pt-select pt-fill pt-large', ->
      select value: viewStore.selectedDashboardId, onChange: onChange, ->
        option value: 0, 'Select Dashboard...'
        viewStore.dashboards.map (dashboard) ->
          option key: dashboard.uuid, value: dashboard.uuid, "#{dashboard.title}" #" / #{dashboard.deviceType}"
))



class SelectDashboard extends React.Component
  onChange: (e) =>
    @props.viewState.setSelectedDashboard(e.target.value)

  render: ->
    {viewState} = @props
    crel DashboardDropDownListView, viewStore: viewState, onChange: @onChange




module.exports = observer(SelectDashboard)


