{extendObservable, action} = require 'mobx'
DashboardModel = (id, title='New Dashboard', deviceType='tablet', defaults=null) ->
  return {
    id: id
    title:  title
    deviceType:  deviceType
    cols:  if deviceType is 'phone' then 80 else 155
    marginX:  0
    marginY:  0
    rowHeight: 5
    widgets:  []
    layouts:  []
    devices:  []
    width:  if deviceType is 'phone' then 500 else 1200
    backgroundColor: defaults?.backgroundColor ? '#be682e'
    color: defaults?.color ? 'white'
  }

WidgetProps = ->
  return {
    backgroundColor: "#ff525b"
    backgroundAlpha: 100
    color: "#fff"
    borderRadius: 2
    cardDepth: 2
  }



class Dashboard
  constructor: (id, dashboard) ->
    @id = id
    @cols =  dashboard.cols
    @marginX =  dashboard.marginX
    @marginY  =  dashboard.marginY
    @rowHeight = dashboard.rowHeight
    @devices = dashboard.devices
    extendObservable(@, {
      title:  dashboard.title
      deviceType:  dashboard.deviceType
      widgets:  dashboard.widgets
      layouts:  dashboard.layouts
      width:  dashboard.width
      backgroundColor: dashboard.backgroundColor
      color: dashboard.color
    })







class DashboardStore_NEW
  constructor: ->
    @dashboards = []
    @createId = 500


  create: (props) ->
    @createId++
    dashboard = new DashboardModel(@createId, props.title, props.deviceType)
    dashboard.widgetProps = new WidgetProps()
#      new Dashboard(@createId, getNewDashboard(props.title, props.deviceType))

    @dashboards.push dashboard
    return dashboard




  getDashboardById: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards[idx]


  load: (d) ->
    console.log 'main'

  getDashboards: ->
    @dashboards

  add: (dashboard) ->
    @activeRecord = dashboard.id
    console.log dashboard, @dashboards
    @dashboards.push dashboard
    return




dashboardStore = new DashboardStore_NEW

module.exports = dashboardStore

