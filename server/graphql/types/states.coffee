{GraphQLObjectType, GraphQLString} = require 'graphql'
exports.deviceStatesType = new GraphQLObjectType({
  name: 'DeviceStatesType'
  fields:
    states: type: GraphQLString
})
