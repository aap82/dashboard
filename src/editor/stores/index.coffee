viewStore = require './viewStore'
deviceStore = require './deviceStore'
editor = require './editor'
DashboardStore = require './dashboardStore'
dashboard = require './dashboardEditor'
widgets = require './widgetEditor'


exports.configureStores = (data, gqlFetch) ->
  editor.fetch = gqlFetch
  deviceStore.loadDevices(data.devices)
  DashboardStore.loadDashboards(data.dashboards, deviceStore.devices)
  viewStore.userDashboards.replace DashboardStore.getUserDashboards()
  return {
    viewStore: viewStore
    deviceStore: deviceStore

    editor: editor
    dashboard: dashboard
    widgetEditor: widgets
  }