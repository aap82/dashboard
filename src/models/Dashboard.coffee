import {setDefaultModelSchema, identifier, object, createSimpleSchema, list} from 'serializr'
import {extendObservable} from 'mobx'
import {widgetSchema} from './Widget'

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
      width: 0
      marginX: 0
      marginY: 0
      cols: 155
      rowHeight: 5
      layouts: []
      widgets: []
      deviceType: 'tablet'
      widgetBorderRadius: 2
      widgetCardDepth: 2
      widgetBackgroundColor: '#be682e'
      widgetBackgroundAlpha: 100
      widgetFontColor: '#fff'
      widgetPrimaryFontSize: 18
      widgetPrimaryFontWeight: 600
      widgetSecondaryFontSize: 14
      widgetSecondaryFontWeight: 18
    }





export dashboardSchema =
  factory: ((context) -> return new DashboardModel(context.args))
  props:
#    id: identifier()
    uuid: identifier()
    cols: yes
    marginX: yes
    marginY: yes
    rowHeight: yes
    title: yes
    deviceType: yes
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