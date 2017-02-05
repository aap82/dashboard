remotedev = require('mobx-remotedev')
{extendObservable, action, computed, toJS, observable} = require 'mobx'
WidgetEditor = require './widgetEditor'
hexToRgba = require('hex-rgba')
DashboardStoreEditor = require './dashboardStore'

Widget = require '../../models/Widget'

class DashboardEditor
  @activeDashboard
  constructor:  ->
    @props = ['cols', 'marginX', 'marginY', 'rowHeight', 'title', 'width', 'deviceType', 'dashboardBackgroundColor', 'widgetBackgroundColor', 'widgetBackgroundAlpha']
    @resetProps = ['deviceType', 'dashboardBackgroundColor', 'widgetBackgroundColor', 'widgetBackgroundAlpha']
    @newDashboardId = 500
    @devices = []
    @newLayout = []
    extendObservable @, {
      activeDashboard: {}
      isDefaultDashboardStyle: no
      isDefaultWidgetStyle: no
      dashboardId: -1
      isEditing: no

      deviceType: ''
      title: 'Dashboard Title'
      cols: ''
      rowHeight: ''
      marginX: ''
      marginY: ''
      width: 1200
      widgets: []
      layouts: []
      setLayout: action(-> @layouts.replace(@newLayout))

      dashboardBackgroundColor: "#fff"
      widgetBackgroundColor: "#fff"
      widgetBackgroundAlpha: 100
      widgetFontColor: "#fff"
      widgetBorderRadius: 2
      widgetCardDepth: 2

      setProp: action((prop, value) ->
        if prop is 'widgetCardDepth' and value > 5 then value = 5
        @["#{prop}"] = value if prop in @props or prop in ['dashboardId', 'widgetFontColor', 'widgetBorderRadius', 'widgetCardDepth', 'widgetBackgroundAlpha']
      )

      load: action((dashboard) ->
        @dashboardId = dashboard.id
        @setAllPropsFromDashboard(dashboard)
        WidgetEditor.key = parseInt(dashboard.widgets[dashboard.widgets.length-1].key, 10) if dashboard.widgets.length > 0
        for widget in dashboard.widgets
          @devices.push widget.device if widget.device not in @devices

      )



      resetAllPropsToDefault: action(->
        @dashboardId = -1
        @deviceType = 'tablet'
        @title = 'Dashboard Title'
        @cols = 155
        @marginX = 0
        @marginY = 0
        @rowHeight = 5
        @widgetCardDepth = 2
        @widgetBackgroundColor = "#4e6eff"
        @widgetBackgroundAlpha = 100
        @dashboardBackgroundColor = "#fff"
        @width = 1200
        @widgetFontColor = "#fff"
        @widgetBorderRadius = 2
        @devices = []
        @widgets.clear()
        @layouts.clear()


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
        @layouts.clear()
        @widgets.clear()
        @newLayout = []
        @dashboardId = -1
      )
      setActiveDashboard: action((dashboard) => @activeDashboard = dashboard)
      create: action((title, deviceType) =>
        @setActiveDashboard DashboardStoreEditor.getDashboard(
          {id: @newDashboardId, title: title, deviceType: deviceType}
        )
        @isEditing = yes
        @newDashboardId++
      )

      deleteWidget: action((widget) ->
        WidgetEditor.stopEditing()
        @widgets.remove(widget)
      )

      addWidget: action(->
        console.log @widgets
        @devices.push "#{WidgetEditor.selectedDevicePlatform}-#{WidgetEditor.selectedDevice}" if WidgetEditor.selectedDevice not in @devices
        @layouts.replace(@newLayout)
        WidgetEditor.key++

        @layouts.push {
          i: WidgetEditor.key.toString()
          w: WidgetEditor.newWidget.w
          h: WidgetEditor.newWidget.h
          x: @cols - WidgetEditor.newWidget.w * 2
          y: 0
          minW: WidgetEditor.newWidget.w
          minH: WidgetEditor.newWidget.h


        }

        @widgets.push {
          platform: WidgetEditor.selectedDevicePlatform
          key: WidgetEditor.key.toString()
          device: WidgetEditor.selectedDevice
          label: WidgetEditor.newWidgetLabel
          type: WidgetEditor.selectedWidgetType
        }

        WidgetEditor.reset()
      )



    }


  toJSON: =>
    toJS({
      title: @title
      deviceType: @deviceType
      cols: @cols
      rowHeight: @rowHeight
      marginX: @marginX
      marginY: @marginY
      widgetCardDepth: @widgetCardDepth
      widgetBackgroundColor: @widgetBackgroundColor
      widgetBackgroundAlpha: @widgetBackgroundAlpha
      widgets: JSON.stringify @widgets.map((widget) -> toJS(widget))
      devices: JSON.stringify @devices
      layouts: JSON.stringify @newLayout
      dashboardStyle: JSON.stringify({
        props: toJS(@dashboardStyle)
      })
      widgetStyle: JSON.stringify({
        props:
          backgroundColor: hexToRgba(@widgetBackgroundColor, @widgetBackgroundAlpha)
          borderRadius: @widgetBorderRadius
      })
    })








dashboardEditor = new DashboardEditor()



module.exports =  remotedev(dashboardEditor)

