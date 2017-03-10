getenv = require('getenv')
Firebase = require("firebase")

NEST_TOKEN = getenv('NEST_TOKEN')

client = new Firebase('wss://developer-api.nest.com')




that = module.exports = ->
  client: new Firebase('wss://developer-api.nest.com')
  devices:
  thermostats:








connectToNestFirebase = ->
