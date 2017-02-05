
viewStore = require('./viewStore')
deviceStore = require('./deviceStore')
editor = require('./editorStore')
DashboardStoreEditor = require('./dashboardStore')
dashboard = require('./dashboardEditor')
widgets = require('./widgetEditor')
stateStore = require('../../stores/DeviceStore')


exports.configureStores = (data, gqlFetch) ->
  editor.fetch = gqlFetch
  stateStore.addDevicesAndStates(data.devicesSetup, JSON.parse data.deviceStates.states)
  widgets.availablePlatforms  = JSON.parse data.devicePlatforms.platforms
  deviceStore.loadDevices(data.devicesSetup)
  DashboardStoreEditor.loadDashboards(data.dashboards, deviceStore.devices)

  viewStore.userDashboards.replace DashboardStoreEditor.getUserDashboards()
  return {
    viewStore: viewStore
    deviceStore: stateStore
    stateStore: stateStore
    editor: editor
    dashboard: dashboard
    widgetEditor: widgets
  }