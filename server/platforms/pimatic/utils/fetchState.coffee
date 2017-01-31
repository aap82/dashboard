fetch = require 'isomorphic-fetch'
{getTransformedObj} = require './jsonMap'
getenv = require('getenv')
host = getenv 'PIMATIC_HOST'
port = getenv 'PIMATIC_PORT'
username = getenv 'PIMATIC_USERNAME'
password = getenv 'PIMATIC_PASSWORD'
URL = 'http://' + username + ':' + password + '@' + host + ':' + port + '/api/devices/'


exports.getDeviceData = ->
  fetch(URL).then (res) ->
    return res.json()
  .then(getTransformedObj)

