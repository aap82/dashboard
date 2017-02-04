{GraphQLList} = require 'graphql'
{deviceType} = require '../types/devices'
{deviceStatesType} = require '../types/states'
DeviceStore = require '../../store'



devicesSetupQuery =
  type: new GraphQLList(deviceType)
  resolve: -> DeviceStore.devices

getFullStateQuery =
  type: deviceStatesType
  resolve: ->
    console.log DeviceStore.states
    return states: JSON.stringify(DeviceStore.states)



module.exports =
    devicesSetupQuery: devicesSetupQuery
    getFullStateQuery: getFullStateQuery