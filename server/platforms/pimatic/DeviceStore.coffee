StateStore = require '../StateStore'
class Device
  constructor: (device) ->
    @platform = device.platform
    @id = device.id
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributes = {}
    for attr in device.attributes
      @attributes[attr.name] = "#{attr.value}"
      StateStore.setState device.platform, device.id, attr.name, attr.value if attr.name isnt ['button']
    @extraInfo =
      deviceClass: device.deviceClass
      deviceClassType: device.deviceClassType
      stateType: device.stateType


class DeviceStore
  constructor: (name) ->
    @platform = name
    @sse = null
    @devices = null



  loadDevices: (userDevices) ->
    return if @devices isnt null
    @devices = {}
    userDevices.map((device) =>
      @devices["#{device.id}"] = new Device(device)

    )
    return




module.exports = DeviceStore