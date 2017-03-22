class DeviceProps
  constructor: (device) ->
    @platform = device.platform
    @id = device.id
    @deviceId = device.deviceId
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributes = device.attributes
    @other = device.other



export default DeviceProps