ViewState = require './stores/viewStore'
editor = require './stores/editorStore'


widgets = require './stores/widgetsStore'
DeviceStore = require '../stores/DeviceStore'

gqlFetch = require('../utils/fetch')('/graphql')
modalStore = require('./stores/modalsStore')

exports.configureStores = (data) ->
  console.log data
  editor.loadUserDevices(data.userDevices)
  deviceStates = if data.deviceStates.states? then JSON.parse(data.deviceStates.states) else []
  DeviceStore.states.replace(deviceStates)
  DeviceStore.addDevice(device) for device in data.devicesSetup
  widgets.devices = DeviceStore.devices
  widgets.platforms = JSON.parse(data.devicePlatforms.platforms)
  return {
    viewState: new ViewState({
      modal: modalStore
      editor: editor
      fetch: gqlFetch
      dashboards: data.dashboards
    })
    editor: editor
    widgets: widgets
    modal: modalStore
    deviceStore: DeviceStore


  }