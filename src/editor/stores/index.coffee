viewStore = require './viewStore'
deviceStore = require './deviceStore'
editor = require './editorStore'
DashboardStore = require './dashboardStore'
dashboard = require './dashboardEditor'
widgets = require './widgetEditor'


exports.configureStores = (data, gqlFetch) ->
  editor.fetch = gqlFetch
  states = JSON.parse data.deviceStates.states
  deviceStore.loadDevices(data.devicesSetup)
  DashboardStore.loadDashboards(data.dashboards, deviceStore.devices)
  viewStore.userDashboards.replace DashboardStore.getUserDashboards()
  return {
    viewStore: viewStore
    deviceStore: deviceStore

    editor: editor
    dashboard: dashboard
    widgetEditor: widgets
  }