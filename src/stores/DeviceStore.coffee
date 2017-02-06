DeviceProps = require '../models/Device'


class DevicesStore
  constructor: ->
    @devices = {}


  addDevice: (device) -> @devices[device.id] = new DeviceProps(device)



  addDevices: (devices) ->
    @devices[device.id] = new DeviceProps(device) for device in devices








devicesStore = new DevicesStore()

module.exports =  devicesStore