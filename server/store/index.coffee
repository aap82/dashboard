Device = require '../../src/models/Device'



that = module.exports =
  ids: []
  devices: []
  platforms: []
  states: {}
  sse: null

  getDevices: -> return @devices
  getPlatforms: -> return @platforms

  getDeviceStateQuery: ->
  getAllStatesQuery: -> {states: JSON.stringify(@states)}
  getPlatformsQuery: -> {platforms: JSON.stringify(@platforms)}
  setSSE: (sse) ->
    @sse = sse
    return


  addPlatform: (platform) ->
    @platforms.push platform if platform not in @platforms
    return


  addDevice: (device) ->
    return if device.id in @ids
    @ids.push device.id
    @devices.push new Device(device, 'server')
    addDeviceToState(device.id, device.type, device.attributes) if device.type not in ['buttons', 'device']
    return

  addDevices: (platform, devices) ->
    if platform not in @platforms then @addPlatform(platform)
    @addDevice(device) for device in devices
    return



  getStates: (devices) -> ("#{id}": @states[id] for id in devices)




  setDeviceState: (platform, deviceId, attr, value) ->
    id = "#{platform}-#{deviceId}"
    return if !@states[id]?
    return if @states[id][attr] is value
    @states[id].on = value if @states[id].on? and attr in ['state']
    attr = 'on'
    @states[id][attr] = value


    @sse.broadcast('update', [id: id, attribute: attr, value: value]) if @sse.clients.length > 0

    return


addDeviceToState = (id, type, attributes) ->
  that.states[id] = {}
  that.states[id][attr.name] = attr.value for attr in attributes
  return



