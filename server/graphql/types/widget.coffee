{GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLBoolean} = require 'graphql'
exports = module.exports

widgetStyleType = new GraphQLObjectType({
  name: 'WidgetStyleType'
  fields:
    backgroundColor: type: GraphQLString
    borderRadius: type: GraphQLString

})

widgetDeviceFields = new GraphQLObjectType({
  name: 'WidgetDeviceType'
  fields: =>
    id: type: GraphQLString
    deviceId: type: GraphQLString
    platform: type: GraphQLString
})



exports.widgetType = new GraphQLObjectType({
  name: 'Widget'
  fields:
    key: type: GraphQLString
    label: type: GraphQLString
    type: type: GraphQLString
    attrNames:
      type: GraphQLString
    cardDepth: type: GraphQLInt
    style: type: widgetStyleType
    device:
      type: widgetDeviceFields

    overrideStyle: type: GraphQLBoolean
})

exports.WidgetQueryFields = "
  key
  label
  type
  attrNames
  cardDepth
  device {
    id
    deviceId
    platform

  }
  style {
    backgroundColor
    borderRadius

  }
  overrideStyle


"