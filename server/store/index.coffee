#Device = require '../../src/models/Device'
{setDeviceProps} = require '../../src/stores/helpers'
SSE = require '../sse'
class Device
  constructor:  ->
    @platform = ''
    @id = ''
    @deviceId = ''
    @name = ''
    @type = ''
    @actions = ''
    @attributes = ''
    @details = {}

that = module.exports =
  ids: []
  devices: []
  platforms: []
  states: {}
  sse: SSE

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
    @devices.push setDeviceProps(new Device(), device)
    if device.state? then @states[device.id] = device.state
    return

  addDevices: (platform, devices) ->
    if platform not in @platforms then @addPlatform(platform)
    @addDevice(device) for device in devices
    return



  getStates: (devices) -> ("#{id}": @states[id] for id in devices)

  getStatesObj: (devices) ->
    response = {}
    response[id] = @states[id] for id in devices
    response




  setDeviceState: (platform, deviceId, attr, value) ->
    id = "#{platform}-#{deviceId}"
    return if !@states[id]?
    return if @states[id][attr] is value
    @states[id][attr] = value
    SSE.broadcastTopicUpdate(id, JSON.stringify ["#{id}": @states[id]])

    return


