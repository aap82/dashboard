getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
io = require('socket.io-client')
u = encodeURIComponent(username)
p = encodeURIComponent(password)
socketUrl = 'http://' + host + ':' + port + '/?username=' + u + '&password=' + p
{getTransformedObj} = require './utils/jsonMap'
DeviceStore = require './DeviceStore'
PimaticStore = new DeviceStore('pimatic')
StateStore = require '../StateStore'
NewDeviceStore = require '../../stores/DeviceStore'
exports.start =  ->

  socket = io(socketUrl,
    reconnection: true
    reconnectionDelay: 1000
    reconnectionDelayMax: 3000
    timeout: 20000
    forceNew: true
  )
  socket.on 'devices', (devices) ->
    formattedDevices = getTransformedObj({devices: devices})
    PimaticStore.loadDevices formattedDevices
    NewDeviceStore.addDevices('pimatic', formattedDevices)
    console.log NewDeviceStore.getDevices()
    return

  socket.on 'deviceAttributeChanged', (attrEvent) ->
    StateStore.updateState('pimatic', attrEvent.deviceId, attrEvent.attributeName, attrEvent.value)
    return


  socket.on 'error', (error) ->
    console.log error
    return
  socket