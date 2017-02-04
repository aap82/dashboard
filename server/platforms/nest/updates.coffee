getenv = require('getenv')
Firebase = require("firebase")

NEST_TOKEN = getenv('NEST_TOKEN')
NEST_STRUCTURE_ID = getenv('NEST_STRUCTURE_ID')

client = new Firebase('wss://developer-api.nest.com')
console.log NEST_TOKEN




#  awayChanges snapshot.child('structures').child(structureId).child('away')
#  thermChanges camelCase(therm.child(id).child('name').val()), therm.child(id) for id, data of thermData

exports.start = ->
  client.authWithCustomToken NEST_TOKEN, (error) ->
    if (error)
      console.log('Error in connecting Firebase Socket.', error)
    else
      console.log('Firebase socket is connected.')

  client.once 'value', (snapshot) =>
    therm = snapshot.child('devices/thermostats')
    thermData = therm.val()
    console.log thermData