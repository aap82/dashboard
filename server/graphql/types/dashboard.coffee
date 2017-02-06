{GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLInputObjectType, GraphQLList} = require 'graphql'
{widgetType, WidgetQueryFields} = require './widget'
{dashboardEditorType, DashboardEditorQueryFields} = require './editor'



dashboardLayoutType = new GraphQLObjectType({
  name: 'DashboardLayoutType'
  fields:
    i: type: GraphQLString
    w: type: GraphQLInt
    h: type: GraphQLInt
    x: type: GraphQLInt
    y: type: GraphQLInt
    minW: type: GraphQLInt
    minH: type: GraphQLInt
})

dashboardStyleType = new GraphQLObjectType({
  name: 'DashboardStyleType'
  fields:
    backgroundColor: type: GraphQLString
    color: type: GraphQLString

})
exports = module.exports
exports.dashboardType = new GraphQLObjectType({
  name: 'Dashboard'
  fields: =>
    id: type: GraphQLInt
    title: type: GraphQLString
    deviceType:  type: GraphQLString
    cols: type: GraphQLInt
    marginX: type: GraphQLInt
    marginY: type: GraphQLInt
    rowHeight: type: GraphQLInt

    style: type:  dashboardStyleType
    layouts:
      type: new GraphQLList(dashboardLayoutType)
      resolve: (obj) -> JSON.parse(obj.layouts)
    widgets:
      type: new GraphQLList(widgetType)
      resolve: (obj) ->
        if obj.widgets? then JSON.parse(obj.widgets)
        else return

    devices: type: GraphQLString
    widgetEditor:
      type: dashboardEditorType
      resolve: (obj) ->
        if obj.widgetEditor? then JSON.parse(obj.widgetEditor)
        else return

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
    style: type:  GraphQLString
    editor: type: GraphQLString
    layouts: type: GraphQLString
    widgets: type: GraphQLString
    devices: type: GraphQLString
    widgetEditor: type: GraphQLString
})



exports.DashboardSetupFields = "
  id
  title
  deviceType
  cols
  rowHeight
  marginX
  marginY
  layouts {
    i
    x
    y
    w
    h
    minH
    minW
  }

  style {
    backgroundColor
    color
  }
  devices
  widgets {#{WidgetQueryFields}}
  widgetEditor {#{DashboardEditorQueryFields}}

"
