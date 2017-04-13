import {update, getDefaultModelSchema, setDefaultModelSchema, deserialize, serialize} from  'serializr'
import {extendObservable, action, toJS, observable, computed, runInAction} from 'mobx'
import buttons from '../LeftPanel/buttons/buttons'
import Button from './buttonsStore'
import {dashboardSchema, dashboard} from '../models/Dashboard'
import { dashboardStore } from './Dashboard'
import {widgetSchema, widgetStore} from '../models/Widget'
import uuidV4 from 'uuid/v4'
import newEditor from '../stores/Editor'
import Color from 'color'



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
    widgetBorderRadius: 2
    widgetCardDepth: 2
    widgetBackgroundColor: '#be682e'
    widgetBackgroundAlpha: 100
    widgetFontColor: '#fff'
    widgetFontSizePrimary: 18
    widgetFontSizeSecondary: 12
    widgetFontWeightPrimary: 500
    widgetFontWeightSecondary: 600

  }

class EditorView
  constructor: (dashboard, store) ->

    @fetch = null
    @createId = 500
    @widgetKey = 0
    @dashboard = dashboard
    @activeWidget = {}
    @activeLayout = {}
    @dashboards = store.dashboards
    @device = null
    extendObservable @, {
      zoom: 1.25
      selectedDashboardId: '0'
      deviceDashboards: []
      editingWidgets: []
      editingLayouts: []
      buttons: {}
      backup: null
      isEditing: no
      startEditing: action(->
        @isEditing = yes
        newEditor.isEditing = yes

      )
      stopEditing: action(->
        @editingWidgets.clear()
        @editingLayouts.clear()
        @isEditing = no
        newEditor.isEditing = no
      )






      deviceId: ''
      userDevices: observable.map({})
      loadUserDevices: action((userDevices) ->
        for device in userDevices
          @userDevices.set(device.ip, observable.map(device))
      )

      updateDevice: action((update) -> @userDevices.get(@deviceId).replace(update))

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
        runInAction(=>
          device = toJS(@device)
          @widgetKey = 0
          @selectedDashboardId = '0'
          dashboard = serialize(dashboardSchema, createDashboard(title, device))
          @fetch('opName', 'CreateDashboard', {dashboard: dashboard})
          .then(action('CreateDashboard-callback', (response) =>
              if response.data.createDashboard?
                @selectedDashboardId = dashboard.uuid
                @dashboards.set(dashboard.uuid, deserialize(dashboardSchema, dashboard))
                @dashboard = @dashboards.get(dashboard.uuid)
                @isEditing = no
                newEditor.isEditing = no
                @backup = serialize(dashboardSchema, @dashboard)
              else

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
        runInAction(=>
          if uuid is '0'
            return
          else
            @dashboard = @dashboards.get(uuid)

            @widgetKey = switch @dashboard.widgets.length
              when 0 then 0
              else parseInt @dashboard.widgets[@dashboard.widgets.length - 1].key, 10
            @isEditing = no
            newEditor.isEditing = no
            @backup = serialize(dashboardSchema, @dashboard)
          )
      )

      save: action(->
        runInAction(=>
          dashboard = serialize(dashboardSchema, @dashboard)
          console.log @dashboard.widgets[0]
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
              @dashboards.delete(@dashboard.uuid)
              @isEditing = no
              newEditor.isEditing = no
            else
              console.log response
            return
          )
        )
      )
      restoreSnapshot: action(-> update(dashboardSchema, @dashboard, toJS(@backup)))


      createWidget: action((label, widget, device) =>
        runInAction(=>
          @widgetKey++
          key = @widgetKey.toString()
          @dashboard.widgets.push deserialize(
            widgetSchema,
            getWidget(key, label, widget.id, device, @dashboard),
            ((err, widget) => console.log widget)
            {dashboard: @dashboard }
          )
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




editor = new EditorView(dashboard, dashboardStore)

export default editor
