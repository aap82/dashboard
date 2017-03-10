{createSimpleSchema, list, setDefaultModelSchema, custom, object, identifier, serialize, deserialize} = require 'serializr'
{widgetSchema, WidgetModel} = require './Widget'
setDefaultModelSchema(WidgetModel, widgetSchema)
export layoutSchema = createSimpleSchema({
  i: yes
  w: yes
  h: yes
  x: yes
  y: yes
  minW: yes
  minH: yes
  static: yes
})

export styleSchema = createSimpleSchema({
    position: yes
    height: yes
    width: yes
    backgroundColor: yes
    color: yes
})

export  class DashboardModel
  constructor: ->



export dashboardSchema =
  factory: ((context, json) =>  new DashboardModel)
  props:
    id: identifier()
    cols: yes
    marginX: yes
    marginY: yes
    rowHeight: yes
    title: yes
    deviceType: yes
    width: yes
    layouts: list(object(layoutSchema))
    widgets: list(object(widgetSchema))
    width: yes
    backgroundColor: yes

    widgetBorderRadius: yes
    widgetCardDepth: yes
    widgetBackgroundColor: yes
    widgetBackgroundAlpha: yes
    widgetFontColor: yes



setDefaultModelSchema(DashboardModel, dashboardSchema)
#
#
#exports.layoutSchema = layoutSchema
#exports.dashboardSchema = dashboardSchema
#exports.styleSchema = styleSchema
#exports.Dashboard = Dashboard
