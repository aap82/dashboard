sse = require '../middleware/utils/sse'





class Device
  constructor: (device) ->
    @platform = device.platform
    @id = device.id
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributeNames = (attr.name for attr in device.attributes)
    @attributes = device.attributes
    @extraInfo = device.extraInfo






class StateStore
  constructor: (sse)->
    @sse = sse
    @platforms = []
    @devices = []
    @deviceStates = {}

  getId = (platform, device, attr) -> return platform + '-' + device + '-' + attr

  setState: (platform, device, attr, state) ->
    id = getId(platform, device, attr)
    @deviceStates[id] = state
    return

  updateState: (platform, device, attr, state) ->
    console.log 'hi ' + state
    id = getId(platform, device, attr)
    if @deviceStates[id] isnt state
      @sse.broadcast(platform, device, {device: device, attr: attr, value: state})
      @deviceStates[id] = state
    return


stateStore = new StateStore(sse)

module.exports = stateStore