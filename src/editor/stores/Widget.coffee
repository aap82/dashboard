{extendObservable} = require 'mobx'



class EditableWidget
  constructor: (widgetStyleProps, widgetProps) ->
    console.log widgetProps
    extendObservable(@, {
      overrideStyle: no
      key: widgetProps.key
      label: widgetProps.label
      type: widgetProps.type
      cardDepth: widgetStyleProps.cardDepth
      attrNames: widgetProps.attrNames
      style:
        backgroundColor: widgetStyleProps.backgroundColor
        borderRadius: widgetStyleProps.borderRadius
        color: widgetStyleProps.color
      device:
        id: widgetProps.device.id
        platform: widgetProps.device.platform
        deviceId: widgetProps.device.deviceId


      
      
    })


module.exports = EditableWidget
