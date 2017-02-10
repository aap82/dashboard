{ observable} = require 'mobx'

DeviceState = (state) ->
  observable.map(state)

class StateStore
  constructor: ->
    @devices = {}

  addDeviceState: (id, state) ->
    @[id] = new DeviceState(state)

  addDeviceStates: (devices) ->
    for device in devices
      if device.state?
        states = JSON.parse(device.state)
        @devices[device.id] = new DeviceState(states)







stateStore = new StateStore()

module.exports =  stateStore