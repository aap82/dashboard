{setDefaultModelSchema, identifier, object, createSimpleSchema, list} = require 'serializr'
{extendObservable} = require 'mobx'
{widgetSchema} = require './Widget'



layoutSchema = createSimpleSchema({
  i: yes
  w: yes
  h: yes
  x: yes
  y: yes
  minW: yes
  minH: yes
  static: yes
})

class DashboardModel
  constructor: ->
    extendObservable @, {
      backgroundColor: '#fff'
      title: ''
      deviceType: ''
      height: 0
      width: 0
      marginX: 0
      marginY: 0
      cols: 155
      rowHeight: 5
      layouts: []
      widgets: []
      deviceType: 'tablet'
      userDevice: ''
      widgetBorderRadius: 2
      widgetCardDepth: 2
      widgetBackgroundColor: '#be682e'
      widgetBackgroundAlpha: 100
      widgetFontColor: '#fff'
    }





export dashboardSchema =
  factory: ((context) -> return new DashboardModel(context.args))
  props:

#    id: identifier()
    uuid: identifier()
    deviceId: yes
    cols: yes
    marginX: yes
    marginY: yes
    rowHeight: yes
    title: yes
    userDevice: yes
    deviceType: yes
    height: yes
    width: yes
    backgroundColor: yes
    layouts: list(object(layoutSchema))
    widgets: list(object(widgetSchema))
    widgetBorderRadius: yes
    widgetCardDepth: yes
    widgetBackgroundColor: yes
    widgetBackgroundAlpha: yes
    widgetFontColor: yes





setDefaultModelSchema(DashboardModel, dashboardSchema)

export Dashboard = new DashboardModel