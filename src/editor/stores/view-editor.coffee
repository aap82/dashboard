{update, getDefaultModelSchema, setDefaultModelSchema, deserialize, serialize} = require 'serializr'
{extendObservable, action, toJS, computed, runInAction} = require 'mobx'
buttons = require '../LeftPanel/buttons/buttons'
Button = require './store-buttons'
{dashboardSchema, Dashboard} = require '../../models/Dashboard'
{dashboardEditorSchema, DashboardEditor} = require '../models/Dashboard'
{widgetEditorSchema, WidgetEditorModel} = require '../models/Widget'
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
      attrNames: widget.attrNames
    })


createWidgetObject = (key, label, widget, device) ->
  return {
    props:
      uuid: uuidV4()
      key: key
      overrideStyle: no
      props:
        attrNames: widget.attrNamesMap[device.platform]
        label: label
        type: widget.id
      localStyle:
        backgroundColor: yes
        borderRadius: yes
        color: yes
      device:
        id: device.id
        platform: device.platform
        deviceId: device.deviceId
        name: device.name
    layout:
      i: key
      w: widget.w
      h: widget.h
      x: 1
      y: 70
      minW: widget.w
      minH: widget.h
      static: no
  }


createDashboardObj = (id, title='New Dashboard', deviceType='tablet', defaults=null) ->
  width = if deviceType is 'phone' then 500 else 1200
  return {
    uuid: uuidV4()
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
    width:  width
    backgroundColor: 'yellow'
    color: 'white'

  }



class EditorView
   constructor: (dashboard) ->
    {widgetProps} = dashboard
    @createId = 500
    @widgetKey = 0
    @dashboard = dashboard
    extendObservable @, {
      backup: null
      widgets: []
      widgetProps: widgetProps
      buttons: {}
      isEditing: yes
      isDirty: no
      startEditing: action(-> @isEditing = yes)
      stopEditing: action(-> @isEditing = no)
      create: action((props) ->
        runInAction(=>
          @createId++
          _dash = createDashboardObj(@createId, props.title, 'tablet')
          update(dashboardEditorSchema, @dashboard, _dash)
          return
        )
      )
      save: action(->
        data = serialize(dashboardSchema, @dashboard)
        @testSave(data)
        runInAction(=>
#          data = serialize(dashboardSchema, @dashboard)
          if data.id > 500
            delete data['id']
#            @testSave(data)
            console.log serialize(dashboardEditorSchema, @dashboard).widgets, data.widgets
          @saveSnapshot()
        )
      )

      saveSnapshot: (-> @backup = serialize(dashboardEditorSchema, @dashboard))

      restoreSnapshot: (-> update(dashboardEditorSchema, @dashboard, toJS(@backup)))


      createWidget: action((label, widget, device) =>
        runInAction(=>
          @widgetKey++
          newWidget = createWidgetObject(@widgetKey.toString(), label, widget, device)
          @dashboard.layouts.push newWidget.layout
          @dashboard.widgets.push deserialize(widgetEditorSchema, newWidget.props)
          return
        )



      )
#
      isDirty: computed(=>
        switch
          when JSON.stringify(serialize(dashboardEditorSchema, @dashboard)) isnt JSON.stringify(@backup) then return yes
          else no


      )





    }

    @buttons[key] = new Button(@, value) for key, value of buttons

    @testSave = (dash) ->
      data = serialize(dashboardSchema, dash)
      console.log serialize(dashboardEditorSchema, @dashboard), data
      return null



editor = new EditorView(DashboardEditor)

module.exports = editor
