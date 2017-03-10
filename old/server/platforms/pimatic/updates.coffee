{getTransformedObj} = require './pimaticDeviceTransform'

getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
io = require('socket.io-client')
u = encodeURIComponent(username)
p = encodeURIComponent(password)
socketUrl = 'http://' + host + ':' + port + '/?username=' + u + '&password=' + p


exports.start =  (store) ->
  store.addPlatform('pimatic')
  socket = io(socketUrl,
    reconnection: true
    reconnectionDelay: 1000
    reconnectionDelayMax: 3000
    timeout: 20000
    forceNew: true
  )
  socket.on 'devices', (devices) -> return store.addDevices('pimatic', getTransformedObj({devices: devices}))
  socket.on 'deviceAttributeChanged', (attrEvent) ->
    store.setDeviceState('pimatic', attrEvent.deviceId, attrEvent.attributeName, attrEvent.value)
    return
  socket.on 'error', (error) -> return  console.log 'error'
  socket