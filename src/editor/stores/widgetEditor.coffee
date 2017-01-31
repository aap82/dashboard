{extendObservable, action, computed, observable, toJS} = require 'mobx'
keyBy = require('lodash.keyby')
DeviceStore = require './deviceStore'
WidgetStore = require './widgetStore'
class WidgetEditor
  constructor: ->
    @widget_oldLabel = ''
    @key = 0
    extendObservable @, {
      activeWidget: null
      activeDevice: null
      selectedDevice: '0'
      widgets: WidgetStore.widgets
      newWidget: null

      setActiveWidget: action((widget) -> @activeWidget = widget)

      isEditing: no
      setActiveWidgetLabel: action((label) -> @activeWidget.label = label)


      saveEditChanges: action(->
        @widget_oldLabel = ''
        @stopEditing()
      )

      cancelEditChanges: action(->
        @activeWidget.label = @widget_oldLabel
        @stopEditing()
      )

      startEditing: action((widget) ->
        @reset()
        @setActiveWidget(widget)
        @activeDevice = DeviceStore.devices[widget.device]
        @widget_oldLabel = @activeWidget.label
        @isEditing = yes
      )
      stopEditing: action(->
        @isEditing = no
      )

      reset: action(->
        @activeDevice = null
        @activeWidget = null
        @selectedWidgetType = '0'
        @selectedDevice = '0'
        @newDevicePlatform = '0'
        @newWidgetLabel = 'Widget Label'
        @isEditing = no
      )

      resetAddWidgetDialog: action(->
        @selectedWidgetType = '0'
        @selectedDevice = '0'
        @newDevicePlatform = '0'
        @newWidgetLabel = 'Widget Label'
      )



      availablePlatforms: ['pimatic']
      selectedDevicePlatform: '0'
      changeSelectedDevicePlatform: action((platform) ->
        @selectedDevicePlatform = platform
        if platform is '0'
          @selectedDevice = '0'
      )



      selectedWidgetType: '0'
      changeSelectedWidgetType: action((type)->
        @newWidget = WidgetStore[type]
        if type is '0' or type != @selectedWidgetType
          @selectedDevice = '0'
        @selectedWidgetType = type
      )


      newWidgetLabel: 'Widget Label'
      changeNewWidgetLabel: action((label) -> @newWidgetLabel = label)

      changeSelectedDevice: action((device) ->
        @selectedDevice = device
        @newWidgetLabel = switch device
          when '0' then 'Widget Label'
          else DeviceStore.devices[device].name

      )

      availableDevices: computed(->
        if @selectedWidgetType is '0'
          return []
        else
          types = @newWidget.types
          return ({id: key, name: value.name} for key, value of DeviceStore.devices when value.type in types and value.platform is @selectedDevicePlatform)


      )

      addNewWidgetButtonDisabled: computed(->
        if (@selectedDevicePlatform is '0' or @selectedWidgetType is '0' or @selectedDevice is '0')
            return yes
        else
          return no
      )




    }





widgetEditor = new WidgetEditor()
module.exports = widgetEditor