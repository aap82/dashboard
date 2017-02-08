{extendObservable, action, computed, toJS, observable} = require 'mobx'
WidgetEditor = require './widgetEditor'
hexToRgba = require('hex-rgba')

Dashboard = require './DashboardView'
EditableWidget = require './Widget'
EditableObject = require './EditableObject'
DashboardModel = require '../../models/Dashboard'

dashboard = DashboardModel.create()
dashboard.widgetProps =
  backgroundColor: "#fff"
  backgroundAlpha: 100
  fontColor: "#fff"
  borderRadius: 2
  cardDepth: 2

widgetProps =
  backgroundColor: "#fff"
  backgroundAlpha: 100
  fontColor: "#fff"
  borderRadius: 2
  cardDepth: 2





class DashboardEditor extends Dashboard
  constructor:  ->
    @createId = 500
    @devices = []
    @newLayout = []
    super()
    extendObservable @, {
      isDashboardStyleDefault: no
      isWidgetStyleDefault: no

      create: action((title, type) ->
        @createId++
        dashboard = DashboardModel.create(title, type)
        dashboard.widgetProps = widgetProps
        dashboard.id = @createId
        @setProps(dashboard)
        dashboard
      )

      loadDashboard: action((id) ->
        dashboard = @getDashboardById(id)
        console.log dashboard


      )

      close: action(->
        @layouts.clear()
        @widgets.clear()
        @newLayout = []
        @id = -1
      )

      deleteWidget: action((widget) ->
        WidgetEditor.stopEditing()
        @widgets.remove(widget)
      )



      addWidget: action(=>
        @layouts.replace(@newLayout)
        WidgetEditor.key++
        @layouts.push WidgetEditor.layout
        widget = new EditableWidget(@widgetProps,  WidgetEditor.getProperties())
        @devices.push widget.device.id
        @widgets.push widget
        WidgetEditor.reset()
      )



    }


  toJSON: =>
    dashboard = JSON.parse JSON.stringify(toJS(@))
    dashboard.devices = []
    dashboard.devices.push widget.device.id for widget in dashboard.widgets when widget.device.id not in dashboard.devices
    dashboard[key] = JSON.stringify(value) for key, value of dashboard when typeof value not in ['string', 'number']
    dashboard.widgetEditor = JSON.stringify(@widgetProps)
    return dashboard



dashboardEditor = new DashboardEditor()



module.exports =  dashboardEditor

