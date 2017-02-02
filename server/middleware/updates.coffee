express = require('express')
router = express.Router()
sse = require './utils/sse'

require('../platforms/pimatic/updates').start(sse)



router.get '/pimatic', (req, res) ->
  client = null
  if !req.id?
    client = sse.add(req, res)
    req.id = client.id
  else
    client = sse.getClient(req.id)
  sse.join(client, 'pimatic')
  return




module.exports = router