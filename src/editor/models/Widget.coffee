{getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} = require 'serializr'
uuidV4 = require('uuid/v4')
{extendObservable, action, toJS, computed, runInAction} = require 'mobx'
{widgetPropsSchema, defaultWidgetProps} = require './WidgetProps'
createdWidgets = {}
attrNamesMap = createSimpleSchema({"*": yes})

deviceSchema = createSimpleSchema({
  id: yes
  deviceId: yes
  platform: yes
  name: yes
})


styleSchema = createSimpleSchema({
  backgroundColor: yes
  borderRadius: yes
  color:yes
})
propsSchema = createSimpleSchema({
  label: yes
  type: yes

})

export class WidgetEditorModel
  constructor: (widget, widgetProps) ->
    console.log 'buildingWidget'
    @widgetProps = widgetProps
    @device = widget.device
    @key = widget.key
    extendObservable(@, {
      overrideStyle: no
      localStyle: widgetProps.style
      style: computed(=>
        switch @overrideStyle
          when yes then @localStyle
          else @widgetProps.style
      )
      props:
        label: widget.props.label
        type: widget.props.type
        attrNames: widget.props.attrNames
        cardDepth: computed(=> @widgetProps.cardDepth)
    })




export widgetEditorSchema =
  factory: ((context) =>
    {json} = context
    if !createdWidgets[json.uuid]
      createdWidgets[json.uuid] = new WidgetEditorModel(json, defaultWidgetProps)
    console.log createdWidgets[json.uuid]
    return createdWidgets[json.uuid]
  )

  props:
    uuid: identifier()
    key: identifier()
    widgetProps: object(widgetPropsSchema)
    overrideStyle: yes
    device: object(deviceSchema)
    localStyle: object(styleSchema)


setDefaultModelSchema(WidgetEditorModel, widgetEditorSchema)
