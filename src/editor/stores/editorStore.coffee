import {update, getDefaultModelSchema, setDefaultModelSchema, deserialize, serialize} from  'serializr'
import {extendObservable, action, toJS, observable, computed, runInAction} from 'mobx'
import buttons from '../LeftPanel/buttons/buttons'
import Button from './buttonsStore'

import {dashboardSchema, Dashboard} from '../models/Dashboard'
import {widgetSchema} from '../models/Widget'
import uuidV4 from 'uuid/v4'

import Color from 'color'

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



getWidget = (key, label, type, device, dashboard) ->
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
  style:
    backgroundColor: Color(dashboard.widgetBackgroundColor).alpha(dashboard.widgetBackgroundAlpha/100).hsl().string()
    color: dashboard.widgetFontColor
    borderRadius: dashboard.widgetBorderRadius


getWidgetLayout = (key, widget, rowHeight) ->
  i: key
  w: widget.w
  h: widget.h / rowHeight
  x: 1
  y: 70
  minW: widget.minW or 10
  minH: widget.minH / rowHeight or 10
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
      selectedDashboardId: '0'
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
      getGlobalWidgetStyle: computed(->
        backgroundColor: Color(@dashboard.widgetBackgroundColor).alpha(@dashboard.widgetBackgroundAlpha/100).hsl().string()
        color: @dashboard.widgetFontColor
        borderRadius: @dashboard.widgetBorderRadius

      )



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

      create: action((title) =>
        console.log @dashboards
        runInAction(=>
          device = toJS(@device)
          @widgetKey = 0
          @selectedDashboardId = '0'
          @reset()
          update(dashboardSchema, @dashboard, createDashboard(title, device))
          dashboard = serialize(dashboardSchema, @dashboard)
          @fetch('opName', 'CreateDashboard', {dashboard: dashboard})
          .then(action('CreateDashboard-callback', (response) =>
              if response.data.createDashboard?
                @selectedDashboardId = @dashboard.uuid
                @dashboards.push dashboard
                @isEditing = no
                @backup = serialize(dashboardSchema, @dashboard)
              else
                console.log response
              return
            )
          )
        )
      )

      updateUserDefaultDashboard: action((id, value) =>
        ip = @device.get('ip')
        @fetch('opName', 'UpdateUserDevice', {ip: ip, device: {"#{id}": value}})
        .then(action('UpdateUserDefaultDashboard', (response) =>
            if response.data.updateUserDevice?
              {record} = response.data.updateUserDevice
              @updateDevice(record)
            else
              console.log response
          )
        )
      )

      load: action((uuid) =>
        console.log @dashboard.getWidgetStyle()
        runInAction(=>
          if uuid is '0'
            return

          else
            @reset()
            idx = @dashboards.findIndex((d) => d.uuid is uuid)
            console.log @dashboards[idx]
            dashboard = toJS @dashboards[idx]

            @dashboard.reset()
            @widgetKey = switch dashboard.widgets.length
              when 0 then 0
              else parseInt dashboard.widgets[dashboard.widgets.length - 1].key, 10
            @isEditing = no
            update(dashboardSchema, @dashboard, dashboard)
            @backup = serialize(dashboardSchema, @dashboard)
          )
      )

      save: action(->
        runInAction(=>
          dashboard = serialize(dashboardSchema, @dashboard)
          dashboard.widgets[i].style = @getGlobalWidgetStyle for widget, i in dashboard.widgets when widget.overrideStyle is no
          @fetch('opName', 'UpdateDashboard', {uuid: dashboard.uuid, dashboard: dashboard})
          .then(action('SaveDashboard-callback', (response) =>
              if response.data?
                @updateDashboard(dashboard)
                @backup = serialize(dashboardSchema, @dashboard)
              else
                console.log response
            )
          )

        )
      )

      delete: action(=>
        if @device.get('defaultDashboardId') is @dashboard.uuid
          @updateUserDefaultDashboard('defaultDashboardId', null)
        @fetch('opName', 'DeleteDashboard', {uuid: @dashboard.uuid})
        .then(action('DeleteDashboard-callback', (response) =>
            if response.data.deleteDashboard?
              @selectedDashboardId = '0'
              idx = @dashboards.findIndex((d) => d.uuid is @dashboard.uuid)
              @dashboards.remove(@dashboards[idx])
              @reset()
              @isEditing = no
            else
              console.log response
            return
          )
        )
      )

      reset: action(=>
        runInAction(=>
          @dashboard.title = ''
          @dashboard.widgets.clear()
          @dashboard.layouts.clear()
          orientation = if @device.get('type') is 'phone' then 'portrait' else 'landscape'
          @setDashboardOrientationTo(orientation)
          return
        )
      )

      restoreSnapshot: action(-> update(dashboardSchema, @dashboard, toJS(@backup)))


      createWidget: action((label, widget, device) =>
        runInAction(=>
          @widgetKey++
          key = @widgetKey.toString()
          @dashboard.widgets.push deserialize(widgetSchema, getWidget(key, label, widget.id, device, @dashboard))
          @dashboard.layouts.push getWidgetLayout(key, widget, @dashboard.rowHeight)
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

export default editor
