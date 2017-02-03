{GraphQLObjectType, GraphQLString, GraphQLList} = require 'graphql'
exports = module.exports


attributeType = new GraphQLObjectType({
  name: 'DeviceAttributeType'
  fields: =>
    type: type: GraphQLString
    value: type: GraphQLString
    name: type: GraphQLString
    unit: type: GraphQLString

})

actionType =  new GraphQLObjectType({
  name: 'ActionType'
  fields: =>
    name: type: GraphQLString
    description: type: GraphQLString
})


exports.deviceType = new GraphQLObjectType({
  name: 'DeviceType'
  fields: =>
    id:  type: GraphQLString
    name: type: GraphQLString
    platform: type: GraphQLString
    type: type: GraphQLString
    attributes: type: new GraphQLList(attributeType)
    actions: type: new GraphQLList(actionType)
    extraInfo: type: GraphQLString

})

exports.DevicesQueryFields = "
    id
    platform
    type
    name

    attributes {
      type
      value
      name
      unit
    }
    actions {
      name
      description
    }
"