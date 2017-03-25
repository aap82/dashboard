import {getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} from 'serializr'
import uuidV4 from 'uuid/v4'
import {extendObservable, action, toJS, computed, runInAction} from 'mobx'
createdWidgets = {}

layoutSchema = createSimpleSchema({
  i: yes
  w: yes
  h: yes
  x: yes
  y: yes
  minW: yes
  minH: yes
  static: yes
})

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
    console.log widget
    @device = widget.device
    @key = widget.key
    extendObservable(@, {
      overrideStyle: no
      label: widget.label
      type: widget.type
      style:
        backgroundColor: ''
        borderRadius: 2
        color: ''
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
