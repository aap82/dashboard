Device = require '../../src/models/Device'



that = module.exports =
  ids: []
  devices: []
  platforms: []
  states: {}
  sse: null

  getDevices: -> return @devices
  getPlatforms: -> return @platforms


  setSSE: (sse) ->
    @sse = sse
    return


  addPlatform: (platform) ->
    @platforms.push platform if platform not in @platforms
    return

  addDeviceToState: (id, attributes) ->
    @states[id] = {}
    @states[id][attr.name] = attr.value for attr in attributes
    return

  addDevice: (device) ->
    return if device.id in @ids
    @ids.push device.id
    @devices.push new Device(device, 'server')
    @addDeviceToState(device.id, device.attributes)
    return

  addDevices: (platform, devices) ->
    if platform not in @platforms then @addPlatform(platform)
    @addDevice(device) for device in devices
    return

  getAllStates: -> {states: JSON.stringify(@states)}

  getStates: (devices) -> ("#{id}": @states[id] for id in devices)




  setDeviceState: (platform, deviceId, attr, value) ->
    id = "#{platform}-#{deviceId}"
    console.log @states[id][attr]
    return if @states[id][attr] is value
    @states[id][attr] = "#{value}"
    @sse.broadcast('update', [id: id, attribute: attr, value: value]) if @sse.clients.length > 0

    return






