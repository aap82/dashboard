express = require('express')
router = express.Router()

getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
BASE_URL = 'http://' + username + ':' + password + '@' + host + ':' + port + '/api/device/'


sendCommand = (device, action) -> fetch(BASE_URL + device + '/' + action).then(-> return)

router.get '/:device/:action', (req, res) ->
  res.sendStatus(200)
  console.log 'received pimatic action request'
  sendCommand(req.params.device, req.params.action)
  return




module.exports = router
