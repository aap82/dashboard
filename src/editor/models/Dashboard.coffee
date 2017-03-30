import {setDefaultModelSchema, identifier, object, createSimpleSchema, list} from 'serializr'
import {extendObservable, observable, computed} from 'mobx'
import {Dashboard, dashboardStore} from '../stores/Dashboard'
import {widgetSchema} from './Widget'
import Color from 'color'


#export dashboardStore = new DashboardStore

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



export dashboardSchema =
  factory: ((context) ->
    {args, json} = context
    if !dashboardStore.dashboards.has(json.uuid)
      console.log 'adding'
      dashboardStore.dashboards.set(json.uuid, new Dashboard(json))
    return dashboardStore.dashboards.get(json.uuid)
  )
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
    widgetFontSizePrimary: yes
    widgetFontSizeSecondary: yes
    widgetFontWeightPrimary: yes
    widgetFontWeightSecondary: yes





setDefaultModelSchema(Dashboard, dashboardSchema)

export dashboard = new Dashboard