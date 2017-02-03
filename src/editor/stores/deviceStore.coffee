{extendObservable, action, computed, observable, toJS} = require 'mobx'
widgetEditor = require './widgetEditor'

class Device
  constructor: (device) ->
    console.log device
    @platform = device.platform
    @id = device.id
    @name = device.name
    @type = device.type
##    @deviceClass = device.deviceClass
##    @deviceClassType = device.deviceClassType
#    @stateType = device.stateType
    @actions = device.actions


    extendObservable @, {
      attributes: observable.map({})
    }
    for attr in device.attributes
      val = if attr.type is 'boolean' then JSON.parse(attr.value) else attr.value
      @attributes.set(attr.name, val)

  sendCommand: (command) =>   fetch('/commands/' + @platform +  '/' + @id +  '/' + command).then(-> return)

class DeviceStore
  constructor: ->
    @updates = null
    @devices = {}
    @subscriptions = []


  handlePimaticUpdate: (e) =>

    data = JSON.parse(e.data)
    console.log data
    @devices["#{data.device}"].attributes.set(data.attr, data.value)

  loadDevices: (userDevices) => userDevices.map((device) =>  @devices["#{device.id}"] = new Device(device))

  close: () =>
    @unsubscribeAll()
    return

  addDevice: (id) =>
    return if id in @subscriptions or id is ''
    if @updates is null then @subscribe()
    @subscriptions.push id
    console.log id
    @updates.addEventListener id, @handlePimaticUpdate
    return

  subscribe: =>
    @updates = new EventSource("/updates/pimatic")
    @updates.addEventListener 'office-cold', @handlePimaticUpdate
    @subscriptions.push 'office-cold'
    @updates.onMessage = (e) ->
      console.log 'these are updates'
      console.log e




  unsubscribe: (device) =>
    @updates.close()
    @updates = null
    @subscriptions = []

    return

  unsubscribeAll: =>
    @updates.close() if @updates isnt null
    @updates = null
    @subscriptions = []
    return

deviceStore = new DeviceStore()
module.exports = deviceStore