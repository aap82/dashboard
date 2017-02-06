{extendObservable, action, computed, toJS, observable} = require 'mobx'
ViewStore = require './viewStore'
DashboardModel = require '../../models/Dashboard'
WidgetModel = require '../../models/Widget'
{setDashboardProps, setWidgetProps} = require '../../stores/helpers'

widgetEditorProps =
    backgroundColor: "#fff"
    backgroundAlpha: 100
    fontColor: "#fff"
    borderRadius: 2
    cardDepth: 2


class DashboardStoreEditor


  constructor: ->
    @dashboards = []

  loadDashboardProps: (d) ->
    dashboard = setDashboardProps(new DashboardModel(), d)
    dashboard.widgets = (d.widgets.map((widget) -> setWidgetProps(new WidgetModel(), widget)))
    dashboard.widgetEditor = d.widgetEditor
    dashboard




  loadDashboards: (dashboards) ->
    @dashboards = dashboards.map((d) =>

      @loadDashboardProps(d)
    )
    console.log @dashboards
    return



  getDashboard: (props) =>
    if !props.widgetEditor? then props.widgetEditor =  widgetEditorProps
    dashboard = setDashboardProps(new DashboardModel(props.widgetEditor), props)
    return dashboard



  getUserDashboards: =>
    userDashboards = @dashboards.map((dashboard) -> id: dashboard.id, title: dashboard.title, deviceType: dashboard.deviceType)
    return userDashboards

  getDashboardById: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    return @dashboards[idx]


  createDashboard: (props) ->
    dashboard = setProps(new DashboardModel(), props)
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



dashboardStore = new DashboardStoreEditor()
module.exports = dashboardStore