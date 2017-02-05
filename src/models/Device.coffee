class Device
  constructor: (device, requestor = '') ->
    @platform = device.platform
    @id = device.id
    @deviceId = device.deviceId
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributes = device.attributes
    @details = switch requestor
      when 'client' then JSON.parse(device.other)
      else device.other


module.exports = Device