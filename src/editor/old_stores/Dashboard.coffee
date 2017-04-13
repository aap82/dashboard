import {extendObservable, observable, computed, action} from 'mobx'
import Color from 'color'


export class Dashboard
  constructor: (props = {}) ->
    @uuid = props.uuid
    extendObservable @, {
      backgroundColor: props.backgroundColor or '#fff'
      title: props.title or ''
      height: props.height or 1200
      width: props.width or 600
      marginX: props.marginX or 0
      marginY:props.marginY or   0
      cols: props.cols or 600
      rowHeight: props.rowHeight or 5
      layouts: props.layouts or []
      widgets: props.widgets or []
      deviceType: props.deviceType or 'tablet'
      userDevice: props.userDevice or ''



      widgetBorderRadius: props.widgetBorderRadius or 2
      widgetCardDepth: props.widgetCardDepth or 2
      widgetBackgroundColor: props.widgetBackgroundColor or '#be682e'
      widgetBackgroundAlpha: props.widgetBackgroundAlpha or 100
      widgetFontColor: props.widgetFontColor or '#fff'
      widgetFontSizePrimary: props.widgetFontSizePrimary or 18
      widgetFontSizeSecondary: props.widgetFontSizeSecondary or 12
      widgetFontWeightPrimary: props.widgetFontWeightPrimary or 500
      widgetFontWeightSecondary: props.widgetFontWeightSecondary or 600
      widgetStyle: computed(->
        backgroundColor: Color(@widgetBackgroundColor).alpha(@widgetBackgroundAlpha/100).hsl().string()
        color: @widgetFontColor
        borderRadius: @widgetBorderRadius

      )

    }


  getWidgetStyle: ->
    backgroundColor: Color(@widgetBackgroundColor).alpha(@widgetBackgroundAlpha/100).hsl().string()
    color: @widgetFontColor
    borderRadius: @widgetBorderRadius


class DashboardStore
  constructor: ->
    extendObservable @, {
      dashboards: observable.shallowMap({})
      selected: action('activeDashboard', -> @dashboards.get(@selectedId))
      getDeviceDashboards: action('dashboardsForDevice', (deviceId) -> (dashboard for dashboard in @dashboards.values() when dashboard.userDevice is deviceId))
      load: action((dashboards) =>
        for dashboard in dashboards
          @dashboards.set(dashboard.uuid, new Dashboard(dashboard))
      )


    }




export dashboardStore = new DashboardStore

export default dashboardStore

