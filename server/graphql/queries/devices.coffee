{GraphQLList} = require 'graphql'
{deviceType} = require '../types/devices'
DeviceStore = require '../../stores/DeviceStore'

devicesQuery =
  type: new GraphQLList(deviceType)
  resolve: -> DeviceStore.getDevices()



module.exports =
    devices: devicesQuery