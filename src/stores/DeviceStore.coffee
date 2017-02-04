{extendObservable, action, computed, asMap, toJS} = require 'mobx'
Device = require '../models/Device'

class DeviceState
  constructor: (states) ->
    extendObservable @, {"#{key}": value} for key, value of states


class DevicesStore
  constructor: ->
    @deviceStates = {}
    @devices = {}
  addDevicesAndStates: (devices, states) ->
    for device in devices
      {state} = device
      @devices[device.id] = new Device(device, 'client')
      @devices[device.id].state = new DeviceState(JSON.parse(device.state)) if state?
    return

devicesStore = new DevicesStore()

module.exports =  devicesStore