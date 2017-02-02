getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
io = require('socket.io-client')
u = encodeURIComponent(username)
p = encodeURIComponent(password)
socketUrl = 'http://' + host + ':' + port + '/?username=' + u + '&password=' + p




exports.start = (sse) ->
  socket = io(socketUrl,
    reconnection: true
    reconnectionDelay: 1000
    reconnectionDelayMax: 3000
    timeout: 20000
    forceNew: true
  )
  socket.on 'deviceAttributeChanged', (attrEvent) ->
    console.log attrEvent
    console.log sse.clients.length
    sse.broadcast('pimatic', attrEvent.deviceId, attrEvent)


  socket.on 'error', (error) ->
    console.log error

  socket