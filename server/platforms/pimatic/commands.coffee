

getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
BASE_URL = 'http://' + username + ':' + password + '@' + host + ':' + port + '/api/device/'

exports.pimatic = (device, command) ->
  fetch(BASE_URL + device + '/' + command).then(-> return)
