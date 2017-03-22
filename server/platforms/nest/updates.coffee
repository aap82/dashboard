getenv = require('getenv')
Firebase = require("firebase")
{getTransformedObj} = require './nestDeviceTransform'
#NEST_TOKEN = getenv('NEST_TOKEN')
NEST_TOKEN="c.3tbDQHR4tFqRrGqvhjlIK7kFZC9LSCsDD1vWP3HHqqwFkvrmKaogQN1zVeOV5U1ij5V1JhwIPN0UlkDFfeGiIKnFG0rCwoP88s7eCzzZHFKSQgoZQQqCLAYW2SzBpE63BQ5RrPM36qVAs4YJ"
client = new Firebase('wss://developer-api.nest.com')




#  awayChanges snapshot.child('structures').child(structureId).child('away')
#  thermChanges camelCase(therm.child(id).child('name').val()), therm.child(id) for id, data of thermData

exports.start = (store) ->
  store.addPlatform('nest')
  updateStore = (id, attr, value) ->
    store.setDeviceState(id, attr, value )

  thermostatChanges = (id, thermRef) ->
    thermRef.ref().on 'child_changed', (update, current) ->

  homeAwayChanges = (id, homeAwayRef) ->
    updateStore(id, 'state', homeAwayRef.val())
    homeAwayRef.ref().on 'value', (snap) =>
      updateStore(id, 'state', snap.val())



  client.authWithCustomToken NEST_TOKEN, (error) ->
    if (error)
      console.log('Error in connecting Firebase Socket.', error)
    else
      console.log('Firebase socket is connected.')



  client.once 'value', (snapshot) =>
#    structRef = snapshot.child('structures')
#    for key, value of structRef.val()
#      id = 'nest-' + paramCase(value.name) + '-home-away'
#      console.log id
##      homeAwayChanges id, structRef.child(key).child('away')
#
#    return
    thermsRef = snapshot.child('devices/thermostats')
    _thermData = thermsRef.val()
    store.addDevices('nest', getTransformedObj({devices: (value for key, value of _thermData)}))






