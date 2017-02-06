{extendObservable, action, computed, toJS, observable} = require 'mobx'
WidgetEditor = require './widgetEditor'
hexToRgba = require('hex-rgba')

Dashboard = require './DashboardView'
EditableWidget = require './Widget'



class DashboardEditor
  constructor:  ->
    @defaultWidgetProps =
      backgroundColor: "#0900FF"
      backgroundAlpha: 100
      color: "#fff"
      borderRadius: 2
      cardDepth: 2

    @newDashboardId = 500
    @devices = []
    @newLayout = []
    extendObservable @, {
      isDefaultDashboardStyle: no
      isDefaultWidgetStyle: no
      dashboardId: -1
      isEditing: no
      setLayout: action(-> Dashboard.layouts.replace(@newLayout))
      widgetProps:
        backgroundColor:  "#0900FF"
        backgroundAlpha: 100
        color: "#fff"
        borderRadius: 2
        cardDepth: 2

      setWidgetEditorProp: action((prop, value) -> @widgetProps["#{prop}"] = value)
      widgetStyleProps: computed(->
        backgroundColor: hexToRgba(@widgetProps.backgroundColor, @widgetProps.backgroundAlpha)
        borderRadius: @widgetProps.borderRadius
        color: @widgetProps.color
      )


      startEditing: action(->
        WidgetEditor.reset()
        @isEditing = yes
      )

      stopEditing: action(->
        WidgetEditor.reset()
        @isEditing = no
      )

      close: action(->
        Dashboard.layouts.clear()
        Dashboard.widgets.clear()
        @newLayout = []
        @dashboardId = -1
      )

      load: action((dashboard) ->
        Dashboard.setProps(dashboard)
        @setWidgetEditorProp key, value for key, value of dashboard.widgetEditor when value?
        WidgetEditor.key = parseInt(Dashboard.widgets[Dashboard.widgets.length-1].key, 10) if Dashboard.widgets.length > 0


      )

      create: action((title, deviceType) =>
        Dashboard.setProps({id: @newDashboardId, title: title, deviceType: deviceType})
        @setWidgetEditorProp key, value for key, value of @defaultWidgetProps
        @isEditing = yes
        @newDashboardId++
      )

      deleteWidget: action((widget) ->
        WidgetEditor.stopEditing()
        Dashboard.widgets.remove(widget)
      )

      addWidget: action(=>
        Dashboard.layouts.replace(@newLayout)
        WidgetEditor.key++
        Dashboard.layouts.push WidgetEditor.layout
        widget = new EditableWidget(@widgetProps,  WidgetEditor.getProperties())
        Dashboard.devices.push widget.device.id
        Dashboard.widgets.push widget
        WidgetEditor.reset()
      )



    }


  toJSON: =>
    dashboard = JSON.parse JSON.stringify(toJS(Dashboard))
    dashboard.devices = []
    dashboard.devices.push widget.device.id for widget in dashboard.widgets when widget.device.id not in dashboard.devices
    dashboard[key] = JSON.stringify(value) for key, value of dashboard when typeof value not in ['string', 'number']
    dashboard.widgetEditor = JSON.stringify(@widgetProps)
    return dashboard








dashboardEditor = new DashboardEditor()



module.exports =  dashboardEditor

