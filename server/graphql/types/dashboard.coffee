{GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLInputObjectType} = require 'graphql'
exports = module.exports

exports.dashboardType = new GraphQLObjectType({
  name: 'Dashboard'
  fields:
    id: type: GraphQLInt
    title: type: GraphQLString
    deviceType:  type: GraphQLString

    cols: type: GraphQLInt
    marginX: type: GraphQLInt
    marginY: type: GraphQLInt
    rowHeight: type: GraphQLInt

    dashboardStyle: type:  GraphQLString
    widgetColor: type: GraphQLString
    widgetCardDepth: type: GraphQLInt
    widgetBackgroundAlpha: type: GraphQLInt
    widgetBackgroundColor: type: GraphQLString
    widgetStyle: type: GraphQLString

    layouts: type: GraphQLString
    widgets: type: GraphQLString
    devices: type: GraphQLString

})




exports.dashboardInputType = new GraphQLInputObjectType({
  name: 'DashboardInput'
  fields:
    title: type: GraphQLString
    deviceType:  type: GraphQLString

    cols: type: GraphQLInt
    marginX: type: GraphQLInt
    marginY: type: GraphQLInt
    rowHeight: type: GraphQLInt

    dashboardStyle: type:  GraphQLString
    widgetColor: type: GraphQLString
    widgetCardDepth: type: GraphQLInt
    widgetBackgroundAlpha: type: GraphQLInt
    widgetBackgroundColor: type: GraphQLString
    widgetStyle: type: GraphQLString

    layouts: type: GraphQLString
    widgets: type: GraphQLString
    devices: type: GraphQLString
})



exports.DashboardSetupFields = "
  id
  title
  deviceType
  cols
  dashboardStyle
  widgetStyle
  rowHeight
  marginX
  marginY
  widgets
  widgetCardDepth
  widgetBackgroundColor
  widgetBackgroundAlpha
  layouts
  devices

"
