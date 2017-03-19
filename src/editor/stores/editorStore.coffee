{update, getDefaultModelSchema, setDefaultModelSchema, deserialize, serialize} = require 'serializr'
{extendObservable, action, toJS, observable, computed, runInAction} = require 'mobx'
buttons = require '../LeftPanel/buttons/buttons'
Button = require './buttonsStore'

{dashboardSchema, Dashboard} = require '../models/Dashboard'
{widgetSchema} = require '../models/Widget'
uuidV4 = require('uuid/v4')



class Widget
  constructor: (widget, widgetProps) ->
    @device = widget.device
    @key = widget.key
    extendObservable(@, {
      widgetProps: widgetProps
      overrideStyle: no
      label: widget.label
      type: widget.type
    })



getWidget = (key, label, type, device) ->
  uuid: uuidV4()
  key: key
  overrideStyle: no
  label: label
  type: type
  cardDepth: 2
  device:
    id: device.id
    platform: device.platform
    deviceId: device.deviceId


getWidgetLayout = (key, widget) ->
  i: key
  w: widget.w
  h: widget.h
  x: 1
  y: 70
  minW: widget.minW or 10
  minH: widget.minH or 10
  static: no

createDashboard = (title='New Dashboard', device, defaults=null) ->
  console.log device
  return {
    uuid: uuidV4()
    title:  title
    cols:  device.width
    height: device.height
    width: device.width
    userDevice: device.ip
    marginX:  0
    marginY:  0
    rowHeight: 1
    widgets:  []
    layouts:  []
    devices:  []

    backgroundColor: '#5c5b58'
    color: 'white'

  }

class EditorView
  constructor: (dashboard) ->

    @fetch = null
    @createId = 500
    @widgetKey = 0
    @dashboard = dashboard
    @activeWidget = {}
    @activeLayout = {}
    extendObservable @, {
      zoom: 1.25
      editingWidgets: []
      editingLayouts: []
      dashboards: []
      buttons: {}
      backup: null
      isEditing: no
      startEditing: action(-> @isEditing = yes)
      stopEditing: action(->
        @editingWidgets.clear()
        @editingLayouts.clear()
        @isEditing = no
      )






      deviceId: ''
      userDevices: observable.map({})
      loadUserDevices: action((userDevices) ->
        for device in userDevices
          @userDevices.set(device.ip, observable.map(device))
      )
      device: computed(-> @userDevices.get(@deviceId) )
      updateDevice: action((update) -> @userDevices.get(@deviceId).replace(update))
      setActiveDevice: action((deviceId) -> @deviceId = deviceId)

      getDashboardsForDevice: action(->  @dashboards.filter((dashboard) => dashboard.userDevice is @deviceId))




      dashboardOrientation: computed(-> if @dashboard.height > @dashboard.width then 'portrait' else 'landscape')
      setDashboardOrientationTo: action((target) =>
        runInAction(=>
          if target is 'landscape'
            @dashboard.height = @device.get('width')
            @dashboard.width = @device.get('height')
          else
            @dashboard.height = @device.get('height')
            @dashboard.width = @device.get('width')
          @dashboard.cols = @dashboard.width
          update(dashboardSchema, @dashboard, toJS(@dashboard))
        )
      )

      create: action((title, device) ->
        runInAction(=>
          @widgetKey = 0
          @selectedWidgetId = 0
          @dashboard.widgets.clear()
          @dashboard.layouts.clear()
          @isEditing = yes
          update(dashboardSchema, @dashboard, createDashboard(title, device))
          @setActiveDevice(device.ip)
          @fetch('opName', 'CreateDashboard', {dashboard: serialize(dashboardSchema, @dashboard)}).then(@saveSnapshot)
          @fetch('opName', 'UpdateUserDevice', {ip: device.ip, device: {defaultDashboardId: @dashboard.uuid}}).then (res) =>
            if res.data.updateUserDevice?
              {record} = res.data.updateUserDevice
              @updateDevice(record)
            else
              console.log res
              return
        )
      )

      load: action((uuid) =>
        runInAction(=>
          if uuid is '0'
            return

          else
            @selectedWidgetId = 0
            @selectedLayoutId = 0
            idx = @dashboards.findIndex((d) => d.uuid is uuid)
            dashboard = toJS @dashboards[idx]
            @dashboard.widgets.clear()
            @dashboard.layouts.clear()
            @widgetKey = switch dashboard.widgets.length
              when 0 then 0
              else parseInt dashboard.widgets[dashboard.widgets.length - 1].key, 10
            @isEditing = no
            update(dashboardSchema, @dashboard, dashboard)
            @setActiveDevice(dashboard.userDevice)
            @backup = serialize(dashboardSchema, @dashboard)
          )
      )

      save: action(->
        runInAction(=>
          dashboard = serialize(dashboardSchema, @dashboard)
          @updateDashboard(dashboard)
          @fetch('opName', 'UpdateDashboard', {uuid: dashboard.uuid, dashboard: dashboard}).then(@saveSnapshot)
        )
      )

      delete: action(->
        @fetch('opName', 'DeleteDashboard', {uuid: dashboard.uuid}).then (res) =>
          if res.data.delete?
            @deleteDashboard()


      )

      saveSnapshot: action((response) =>
        console.log response
        runInAction(=>
          if response.data?
            @backup = serialize(dashboardSchema, @dashboard)
        )
      )

      restoreSnapshot: action(-> update(dashboardSchema, @dashboard, toJS(@backup)))


      createWidget: action((label, widget, device) =>
        runInAction(=>
          @widgetKey++
          key = @widgetKey.toString()
          @dashboard.widgets.push deserialize(widgetSchema, getWidget(key, label, widget.id, device))
          @dashboard.layouts.push getWidgetLayout(key, widget)
          return
        )
      )
      updateDashboard: action(=>
        runInAction(=>
          update(dashboardSchema, @dashboard, toJS(@dashboard))
          @updateEditingWidgets()

        )
      )
      updateEditingWidgets: action(=>
        runInAction(=>
          keys = (widget.key for widget in editor.editingWidgets)
          @editingWidgets.replace((widget for widget in @dashboard.widgets when widget.key in keys))
          @editingLayouts.replace((layout for layout in @dashboard.layouts when layout.i in keys))

        )

      )
#
      isDirty: computed(=>
        switch
          when !@isEditing then return no
          when JSON.stringify(serialize(dashboardSchema, @dashboard)) isnt JSON.stringify(@backup) then return yes
          else no
      )


      updateLayout: action((layout) =>
        runInAction(=>
          @dashboard.layouts.replace(layout)
          @updateEditingWidgets()

        )


      )


    }

    @buttons[key] = new Button(@, value) for key, value of buttons




editor = new EditorView(Dashboard)

module.exports = editor
