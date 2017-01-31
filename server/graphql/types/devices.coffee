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
    platform: type: GraphQLString
    id:  type: GraphQLString
    name: type: GraphQLString
    deviceClass: type: GraphQLString #Light, Thermostat, Sensor, etc.
    deviceClassType: type: GraphQLString #define futher...switch, dimmer (with is switch, plus dimming => 0=off, 100=on)
    state: type: GraphQLString
    type: type: GraphQLString
    stateType: type: GraphQLString
    attributes: type: new GraphQLList(attributeType)
    actions: type: new GraphQLList(actionType)


})

exports.DevicesQueryFields = "
    id
    platform
    state
    stateType
    deviceClass
    deviceClassType
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