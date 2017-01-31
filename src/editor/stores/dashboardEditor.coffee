{extendObservable, action, computed, toJS} = require 'mobx'
WidgetEditor = require './widgetEditor'
dashboardDefaultProps = require '../../models/defaultProps'
DeviceStore = require './deviceStore'
hexToRgba = require('hex-rgba')
class DashboardEditor
  constructor: (defaultProps) ->
    @fetch = null
    @props = ['cols', 'marginX', 'marginY', 'rowHeight', 'title', 'width', 'deviceType', 'dashboardBackgroundColor', 'widgetBackgroundColor', 'widgetBackgroundAlpha']
    @resetProps = ['deviceType', 'dashboardBackgroundColor', 'widgetBackgroundColor', 'widgetBackgroundAlpha']
    @defaultProps = defaultProps
    @newDashboardId = 500

    @newLayout = []
    extendObservable @, {
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

      dashboardStyle: computed(->
        position: 'relative'
        height: "100%"
        width: @width
        backgroundColor: @dashboardBackgroundColor
        fontFamily: 'Ubuntu'
        color: @widgetFontColor
      )

      baseWidgetStyle: computed(->
        backgroundColor: hexToRgba(@widgetBackgroundColor, @widgetBackgroundAlpha)
        borderRadius: @widgetBorderRadius
        pointerEvents: if @isEditing then 'none' else 'all'
      )


      setProp: action((prop, value) ->
        if prop is 'widgetCardDepth' and value > 5 then value = 5
        @["#{prop}"] = value if prop in @props or prop in ['dashboardId', 'widgetFontColor', 'widgetBorderRadius', 'widgetCardDepth', 'widgetBackgroundAlpha']
      )

      load: action((dashboard) ->
        @dashboardId = dashboard.id
        @setAllPropsFromDashboard(dashboard)
        WidgetEditor.key = parseInt(dashboard.widgets[dashboard.widgets.length-1].key, 10) if dashboard.widgets.length > 0
        DeviceStore.addDevice(widget.device) for widget in dashboard.widgets

      )




      setAllPropsFromDashboard: action((dashboard) ->
        @deviceType = dashboard.deviceType
        @title = dashboard.title
        @cols = dashboard.cols
        @marginX = dashboard.marginX
        @marginY = dashboard.marginY
        @rowHeight = dashboard.rowHeight

        @widgetCardDepth = dashboard.widgetCardDepth
        @widgetBackgroundColor = dashboard.widgetBackgroundColor
        @widgetBackgroundAlpha = dashboard.widgetBackgroundAlpha


        {dashboardStyle} = dashboard
        @isDefaultDashboardStyle = dashboardStyle.isDefault
        @dashboardBackgroundColor = dashboardStyle.props.backgroundColor
        @width = dashboardStyle.props.width
        @widgetFontColor = dashboardStyle.props.color

        {widgetStyle} = dashboard
        @isDefaultWidgetStyle = widgetStyle.isDefault
        @widgetBorderRadius = widgetStyle.props.borderRadius


        @widgets.replace(dashboard.widgets)
        @layouts.replace(dashboard.layouts)
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
        DeviceStore.close()
        @layouts.clear()
        @widgets.clear()
        @newLayout = []
        @dashboardId = -1
      )

      create: action((title, deviceType) ->
        @setProp(prop, value) for prop, value of @defaultProps["#{deviceType}"] when prop in @props
        @setProp('title', title)
        @setProp('deviceType', deviceType)
        @setProp('dashboardId', @newDashboardId)
        @isEditing = yes
        @newDashboardId++
      )

      deleteWidget: action((widget) ->
        WidgetEditor.stopEditing()
        @widgets.remove(widget)
      )

      addWidget: action(->
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
          platform: WidgetEditor.newDevicePlatform
          key: WidgetEditor.key.toString()
          device: WidgetEditor.selectedDevice
          label: WidgetEditor.newWidgetLabel
          type: WidgetEditor.selectedWidgetType
        }

        DeviceStore.addDevice(WidgetEditor.selectedDevice)
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
      layouts: JSON.stringify @newLayout
      dashboardStyle: JSON.stringify({
        isDefault: @isDefaultDashboardStyle
        props: toJS(@dashboardStyle)
      })
      widgetStyle: JSON.stringify({
        isDefault: @isDefaultWidgetStyle
        props:
          backgroundColor: hexToRgba(@widgetBackgroundColor, @widgetBackgroundAlpha)
          borderRadius: @widgetBorderRadius
      })
    })








dashboardEditor = new DashboardEditor(dashboardDefaultProps)



module.exports =  dashboardEditor

