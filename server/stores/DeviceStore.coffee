class Device
  constructor: (platform, device) ->
    @platform = platform
    @id = device.id
    @name = device.name
    @type = device.type
    @actions = device.actions
    @attributes = device.attributes
    @extraInfo = JSON.stringify(device.extraInfo)


that = module.exports =
  ids: []
  devices: []

  addDevice: (platform, device) ->
    if "#{platform}-#{device.id}" in @ids then return
    @ids.push "#{platform}-#{device.id}"
    @devices.push(new Device(platform, device))
    return

  addDevices: (platform, devices) ->
    @addDevice(platform, device) for device in devices
    return

  getDevices: -> return @devices




