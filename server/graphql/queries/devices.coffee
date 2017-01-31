{GraphQLList} = require 'graphql'
{getDeviceData} = require '../../platforms/pimatic/utils/fetchState'
{deviceType} = require '../types/devices'

devicesQuery =
  type: new GraphQLList(deviceType)
  resolve: -> getDeviceData().then((data) -> return data)



module.exports =
    devices: devicesQuery