{getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} = require 'serializr'
uuidV4 = require('uuid/v4')
{extendObservable, action, toJS, computed, runInAction} = require 'mobx'
createdWidgets = {}


deviceSchema = createSimpleSchema({
  id: yes
  deviceId: yes
  platform: yes
})


widgeStyleSchema = createSimpleSchema({
  backgroundColor: yes
  borderRadius: yes
  color:yes
})


class WidgetModel
  constructor: (widget) ->
    @device = widget.device
    @key = widget.key
    extendObservable(@, {
      overrideStyle: no
      label: widget.label
      type: widget.type
    })




export widgetSchema =
  factory: ((context) =>
    {json} = context
    if !createdWidgets[json.uuid]
      createdWidgets[json.uuid] = new WidgetModel(json)
    return createdWidgets[json.uuid]
  )

  props:
    uuid: identifier()
    key: identifier()
    overrideStyle: yes
    label: yes
    type: yes
    cardDepth: yes
    device: object(deviceSchema)
    style: object(widgeStyleSchema)


setDefaultModelSchema(WidgetModel, widgetSchema)
