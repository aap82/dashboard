{GraphQLList, GraphQLString} = require 'graphql'
{deviceType} = require '../types/devices'
{deviceStatesType, devicePlatformType} = require '../types/states'
DeviceStore = require '../../store/index'



devicesSetupQuery =
  type: new GraphQLList(deviceType)
  resolve: ->    DeviceStore.devices


getDashboardDeviceStatesQuery =
  type: GraphQLString
  args:
    devices: type: new GraphQLList(GraphQLString)
  resolve: (obj, args) =>
    return JSON.stringify(DeviceStore.getStates(args.devices))





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
    getDashboardDeviceStatesQuery: getDashboardDeviceStatesQuery