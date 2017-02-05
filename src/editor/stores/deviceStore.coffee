widgetEditor = require './widgetEditor'
Device = require '../../models/Device'

class DeviceStoreEditor
  constructor: ->
    @devices = {}
    @platforms = []





  loadDevices: (userDevices) ->
    userDevices.map((device) => @devices["#{device.id}"] = new Device(device, 'client'))



deviceStore = new DeviceStoreEditor()
module.exports = deviceStore