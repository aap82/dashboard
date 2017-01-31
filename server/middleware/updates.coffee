express = require('express')
app = express()
sse = require './utils/sse'

require('../platforms/pimatic/updates').start(sse)



app.use '/pimatic',  (req, res) ->
  client = null
  if !req.id?
    client = sse.add(req, res)
    req.id = client.id
  else
    client = sse.getClient(req.id)
  sse.join(client, 'pimatic')
  return


app.get '/', (req, res) ->
  sse.add(req, res)


module.exports = app