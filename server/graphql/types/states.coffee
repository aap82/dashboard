{GraphQLObjectType, GraphQLString} = require 'graphql'
exports.deviceStatesType = new GraphQLObjectType({
  name: 'DeviceStatesType'
  fields:
    states: type: GraphQLString
})

exports.devicePlatformType = new GraphQLObjectType({
  name: 'DevicePlatformType'
  fields:
    platforms: type: GraphQLString
})