{getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} from 'serializr'
uuidV4 from('uuid/v4')
{extendObservable, action, toJS, computed, runInAction} from 'mobx'
createdWidgets = {}


deviceSchema = createSimpleSchema({
  id: yes
  deviceId: yes
  platform: yes
})


widgetStyleSchema = createSimpleSchema({
  backgroundColor: yes
  borderRadius: yes
  color:yes
})

widgetFontSizeSchema = createSimpleSchema({
  primaryFontSize: yes
  primaryFontWeight: yes
  secondaryFontSize:yes
  secondaryFontWeight: yes
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
    style: object(widgetStyleSchema)
    fonts: object(widgetFontSizeSchema)


setDefaultModelSchema(WidgetModel, widgetSchema)
