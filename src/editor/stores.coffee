viewStore = require './editor/stores/viewStore'
deviceStore = require './editor/stores/deviceStore'
editor = require './editor/stores/editor'
DashboardStore = require './editor/stores/dashboardStore'
dashboard = require './editor/stores/dashboardEditor'
widgets = require './editor/stores/widgetEditor'


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