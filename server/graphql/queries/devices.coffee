{GraphQLList} = require 'graphql'
{deviceType} = require '../types/devices'
{deviceStatesType, devicePlatformType} = require '../types/states'
DeviceStore = require '../../store'



devicesSetupQuery =
  type: new GraphQLList(deviceType)
  resolve: -> DeviceStore.devices

getFullStateQuery =
  type: deviceStatesType
  resolve: -> DeviceStore.getAllStatesQuery()

getAllPlatformsQuery =
  type: devicePlatformType
  resolve: -> DeviceStore.getPlatformsQuery()

module.exports =
    devicesSetupQuery: devicesSetupQuery
    getFullStateQuery: getFullStateQuery
    getAllPlatformsQuery: getAllPlatformsQuery