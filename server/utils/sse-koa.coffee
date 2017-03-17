async = require('asyncawait/async')
PassThrough = require('stream').PassThrough
that = module.exports =
  clients: []
  heartbeat: 20000
  getClient: (id) ->
    i = 0
    while i < @clients.length
      if @clients[i].id == id
        return @clients[i]
      i++
    null
  add: (ctx) ->
    _id = uid++
    _o =
      id: _id
      rooms: []
      devices: []
      stream: new PassThrough()
      res: ctx.res
    @clients.push _o
    ctx.socket.setTimeout 0x7FFFFFFF
    ctx.req.on 'close', ->
      that.remove _id
      ctx.res.end()
      return
    ctx.type = 'text/event-stream'
    #should start interval ?
    if !heartInterval
      heartInterval = setInterval(that.sendHeartbeat, that.heartbeat)
    ctx.body = _o.stream

    _o

  remove: (id) ->
    if typeof id == 'object'
      id = id.id
    i = 0
    while i < @clients.length
      if @clients[i].id == id
        @clients.splice i, 1
        #should stop interval ?
        if that.clients.length == 0
          clearInterval heartInterval
        return
      i++
    return
  join: (client, room) ->
    client = convertClient(client)
    if @in(client, room)
      return false
    client.rooms.push room
    true
  leave: (client, room) ->
    client = convertClient(client)
    if room == '*' or !room
      client.rooms = []
      return
    i = 0
    while i < client.rooms.length
      if client.rooms[i] == room
        client.rooms.splice i, 1
      i++
    return
  in: (client, room) ->
    client = convertClient(client)
    if room == '*'
      return true
    client.rooms.indexOf(room) > -1
  send: (client, event, data) ->
    client = convertClient(client)
    if event == undefined
      return
    if data == undefined
      data = event
      event = null
    client.res.write 'id: ' + client.id + '\n'
    if event != null
      client.res.write 'event: ' + event + '\n'
    #Clean data
    if typeof data == 'object'
      data = JSON.stringify(data)
    else if typeof data == 'number'
      data = data.toString()
    data = data.split('\n')
    i = 0
    while i < data.length
      client.res.write 'data: ' + data[i] + '\n'
      i++
    client.res.write '\n'
    #For compression module of express
    if client.res.flush
      client.res.flushHeaders()
    return
  broadcast: (room, event, data) ->
    i = 0
    while i < @clients.length
      if @in(@clients[i], room)
        @send @clients[i], event, data
      i++
    return
  setRetry: (client, retry) ->
    client = convertClient(client)
    client.res.write 'id: ' + client.id + '\n'
    client.res.write 'retry: ' + retry + '\n'
    client.res.write '\n'
    if client.res.flush
      client.res.flushHeaders()
    return
  sendHeartbeat: ->
    i = 0
    while i < that.clients.length
      that.clients[i].res.write ':heartbeat signal\n\n'
      if that.clients[i].res.flush
        that.clients[i].res.flushHeaders()
      i++
    return

###*** PRIVATE ****###

uid = 0
heartInterval = null

###*
# Convert a client id to a full client object if needed.
# @param  {Client} client A client object or a client id.
# @return {Object}        The client object associated.
###

convertClient = (client) ->
  if typeof client == 'object'
    client
  else
    client = that.getClient(client)
    if !client
      throw Error(client + ' SSE client does not exist.')
    client
