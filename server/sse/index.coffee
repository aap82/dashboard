uid = 0
class SSE
  constructor: ->
    @clients = []
    @heartbeat = 20000
    @heartInterval = null


  add: (stream, topics = []) =>
    _client = 
      id: uid++
      stream: stream
      topics: topics
    @clients.push _client
    if @heartInterval is null
      @heartInterval = setInterval(@sendHeartbeat, 20000)
    return _client.id


  remove: (id) =>
    idx = @clients.findIndex((c) -> c.id is id)
    @clients.splice idx, 1 if @clients[idx]?
    console.log 'remove'
    if @clients.length is 0
      clearInterval @heartInterval
      @heartInterval = null


  broadcastData: (data) =>
    @sendData(client, data) for client in @clients
    return

  broadcastEvent: (event, data) =>
    @sendData(client, event, data) for client in @clients when event in client.topics
    return

  broadcastTopicUpdate: (topic, data) =>
    @sendEventData(client, 'update', data) for client in @clients when topic in client.topics


  sendEventData: (client, event, data) =>
    client.stream.write "event:#{ event }\ndata: #{ data }\n\n"

  sendData: (client, data) =>
    client.stream.write "data: #{ data }\n\n"

  sendMessage: (client, msg) =>
    client.stream.write ":#{msg }\n\n"
    return


  sendHeartbeat: => client.stream.write ':heartbeat signal\n\n' for client in @clients
    



SSE = new SSE()

module.exports = SSE
