widgetEditor = require './widgetEditor'
Device = require '../../models/Device'
#class Device
#  constructor: (device) ->
#    @id = device.id
#    @platform = device.platform
#    @device = device.deviceId
#    @name = device.name
#    @type = device.type
#    @actions = device.actions
#    @attributes = device.attributes
#    @states = {}
#    for attr in device.attributes
#      val = if attr.type is 'boolean' then JSON.parse(attr.value) else attr.value
#      @states[attr.name] =  val
#
#  sendCommand: (command) =>   fetch('/commands/' + @platform +  '/' + @device +  '/' + command).then(-> return)
#
#

class DeviceStore
  constructor: ->
    @devices = {}
    @platforms = []





  loadDevices: (userDevices) ->
    userDevices.map((device) => @devices["#{device.id}"] = new Device(device, 'client'))



deviceStore = new DeviceStore()
module.exports = deviceStore