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
        viewStore.userDashboards.map (dashboard) ->
          option key: dashboard.id, value: dashboard.id, "#{dashboard.title}" #" / #{dashboard.deviceType}"
))



class SelectDashboard extends React.Component
  onChange: (e) =>
    id = parseInt(e.target.value, 10)
    @props.viewStore.setSelectedDashboard(id)

  render: ->
    {viewStore} = @props
    crel DashboardDropDownListView, viewStore: viewStore, onChange: @onChange



module.exports = observer(SelectDashboard)


