class Device
  constructor: (device, requestor) ->
    @platform = device.platform
    @id = device.id
    @deviceId = device.deviceId
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributes = device.attributes
    @extraInfo = switch requestor
      when 'server' then JSON.stringify(device.extraInfo)
      when 'client' then JSON.parse(device.extraInfo)


module.exports = Device