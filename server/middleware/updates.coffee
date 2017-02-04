express = require('express')
router = express.Router()
sse = require './utils/sse'
Store = require '../store'
Store.setSSE(sse)
require('../platforms/pimatic/updates').start(Store)
require('../platforms/nest/updates').start()



router.get '/', (req, res) ->
  client = null
  if !req.id?
    client = sse.add(req, res)
    req.id = client.id
  else
    client = sse.getClient(req.id)
  sse.join(client, 'pimatic')
  return




module.exports = router