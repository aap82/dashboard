DeviceStore = require './stores/DeviceStore'

exports.configureStores = (data) ->
  console.log data
  deviceStates = if data.deviceStates? then JSON.parse(data.deviceStates) else []
  DeviceStore.addDeviceState(deviceState) for deviceState in deviceStates
  return {
    dashboard:  data.dashboard
    deviceStore: DeviceStore
  }