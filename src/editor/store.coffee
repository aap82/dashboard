ViewState = require './stores/view-state'
dashboards = require './stores/store-dashboards'
editor = require './stores/view-editor'

{setDefaultModelSchema, createModelSchema, primitive, reference, list, object, identifier, serialize, deserialize} = require 'serializr'

widgets = require './stores/view-widgets'
StateStore = require '../stores/StateStore'
DeviceStore = require '../stores/DeviceStore'

gqlFetch = require('../utils/fetch')('/graphql')
modalStore = require('./stores/store-modals')

loadDevicesAndStates = (devices) =>
  for device in devices
    StateStore.addDeviceState(device.id, JSON.parse(device.state)) if device.state?
    DeviceStore.addDevice(device)




exports.configureStores = (data) ->
  console.log data

  loadDevicesAndStates(data.devicesSetup)
  widgets.platforms = JSON.parse(data.devicePlatforms.platforms)
  widgets.devices = DeviceStore.devices

  return {
    viewState: new ViewState({
      modal: modalStore
      editor: editor
      store: dashboards
    })
    editor: editor
    widgets: widgets
    modal: modalStore
    devices: DeviceStore
    states: StateStore


  }