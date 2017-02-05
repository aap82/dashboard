{GraphQLObjectType, GraphQLString, GraphQLList} = require 'graphql'
DeviceStore = require '../../store'
exports = module.exports


attributeType = new GraphQLObjectType({
  name: 'DeviceAttributeType'
  fields: =>
    type: type: GraphQLString
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
    deviceId:  type: GraphQLString
    name: type: GraphQLString
    platform: type: GraphQLString
    type: type: GraphQLString
    attributes: type: new GraphQLList(attributeType)
    actions: type: new GraphQLList(actionType)
    other:
      type: GraphQLString
      resolve: (root) -> return JSON.stringify(root.other)
    state:
      type: GraphQLString
      resolve: (root) ->
        return JSON.stringify(DeviceStore.states[root.id])



})




exports.DevicesQueryFields = "
    id
    deviceId
    platform
    type
    name
    other
    attributes {
      type
      name
      unit
    }
    actions {
      name
      description
    }
    state
"