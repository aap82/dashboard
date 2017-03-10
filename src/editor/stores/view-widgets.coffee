{extendObservable, action, computed, observable, toJS} = require 'mobx'
DeviceStore = require '../../stores/DeviceStore'
WidgetStore = require './store-widgets'


createWidgetObject = () ->

Widget = (key, widget, device, props) ->
  return {
    key: key
    overrideStyle: no
    label: widget.label
    type: widget.type
    attrNames: {}
    device:
      id: device.id
      platform: device.platform
      deviceId: device.deviceId



  }


class Widgets
  constructor: (@widgets, @widgetTypes) ->
    @devices
    @platforms
    @key = 0
    extendObservable @, {

      getWidget: action((widget, device, globalProps) =>
        @key++
        newWidget = new Widget(@key.toString(), widget, device, globalProps)
        newWidget.attrNames =  @widgets[widget.type].attrNamesMap[device.platform]
        layout =
          i: @key.toString()
          w: widget.props.w
          h: widget.props.h
          minW: widget.props.w
          minH: widget.props.h
          x: 1
          y: 50


        return widget: newWidget, layout: layout
      )


      layout: computed(=>
        toJS({
          i: @key.toString()
          w: @newWidget.w
          h: @newWidget.h
          x: 1
          y: 70
          minW: @newWidget.w
          minH: @newWidget.h
          static: no
        })
      )


    }







widgets = new Widgets(WidgetStore, WidgetStore.widgetTypes)
module.exports = widgets