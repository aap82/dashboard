ViewStore = require './viewStore'
class Dashboard
  constructor: ->
    @id
    @deviceType
    @title
    @cols
    @marginX
    @marginY
    @rowHeight
    @widgetCardDepth
    @dashboardStyle
    @widgetStyle
    @widgets
    @layouts
    @devices

    @width
    @widgetBackgroundColor
    @widgetBackgroundAlpha




class DashboardStore
  constructor: ->
    @dashboards = []

  getUserDashboards: =>
    userDashboards = @dashboards.map((dashboard) -> id: dashboard.id, title: dashboard.title, deviceType: dashboard.deviceType)
    return userDashboards

  getDashboardById: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    return @dashboards[idx]



  loadDashboards: (array) ->
    @dashboards = array.map((dashboard) => setProps(new Dashboard(), dashboard))
    return


  createDashboard: (props) ->
    dashboard = setProps(new Dashboard(), props)
    @dashboards.push dashboard
    ViewStore.userDashboards.replace @getUserDashboards()
    ViewStore.setSelectedDashboard props.id
    return

  updateDashboard: (id, props) ->
    dashboard = @getDashboardById(id)
    setProps(dashboard, props)
    ViewStore.userDashboards.replace @getUserDashboards()
    return


  deleteDashboard: (id) =>
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards.splice(idx)
    ViewStore.userDashboards.replace @getUserDashboards()
    ViewStore.handleDeletedDashboard()
    return

setProps = (dashboard, props) ->
    if props.id? then dashboard.id = props.id
    dashboard.deviceType = props.deviceType
    dashboard.title = props.title
    dashboard.cols = props.cols
    dashboard.marginX = props.marginX
    dashboard.marginY = props.marginY
    dashboard.rowHeight = props.rowHeight
    dashboard.widgetCardDepth = props.widgetCardDepth
    dashboard.dashboardStyle = JSON.parse(props.dashboardStyle)
    dashboard.widgetStyle = JSON.parse(props.widgetStyle)
    dashboard.widgets = JSON.parse(props.widgets)
    dashboard.layouts = JSON.parse(props.layouts)
    dashboard.devices = JSON.parse(props.devices)

    dashboard.width = props.width or 1200
    dashboard.widgetBackgroundColor = props.widgetBackgroundColor
    dashboard.widgetBackgroundAlpha = props.widgetBackgroundAlpha
    dashboard



dashboardStore = new DashboardStore()
module.exports = dashboardStore