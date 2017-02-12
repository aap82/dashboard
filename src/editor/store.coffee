ViewState = require './stores/view-state'
dashboarboardStore_New = require './stores/store-dashboards'
editorView = require './stores/view-editor'




ViewStore = require './stores/viewStore'
DashboardStoreEditor = require './stores/dashboardStore'
dashboardEditor = require './stores/dashboardEditor'
widgets = require './stores/widgetEditor'
StateStore = require '../stores/StateStore'
DeviceStore = require '../stores/DeviceStore'

gqlFetch = require('../utils/fetch')('/graphql')
modalStore = require('./stores/modalStore')

loadDevicesAndStates = (devices) =>
  for device in devices
    StateStore.addDeviceState(device.id, JSON.parse(device.state)) if device.state?
    DeviceStore.addDevice(device)




exports.configureStores = (data) ->


  loadDevicesAndStates(data.devicesSetup)
  DashboardStoreEditor.init(data.dashboards, gqlFetch)
  widgets.availablePlatforms = JSON.parse data.devicePlatforms.platforms
  viewStore = new ViewStore({
    modal: modalStore
    editor: dashboardEditor
    store: DashboardStoreEditor
  })

  viewState = new ViewState({
    modal: modalStore
    editor: editorView
    store: dashboarboardStore_New
  })

  return {
    viewState: viewState
    editorView: editorView

    modal: modalStore
    devices: DeviceStore
    states: StateStore
    editor: dashboardEditor
    widgetEditor: widgets
    viewStore: viewStore
  }