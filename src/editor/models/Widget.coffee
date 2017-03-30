import {getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} from 'serializr'
import uuidV4 from 'uuid/v4'
import {extendObservable, observable, action, toJS, computed, runInAction} from 'mobx'
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
class WidgetStore
  constructor: ->
    extendObservable @, {
      widgets: observable.map({})
    }
export widgetStore = new WidgetStore


class WidgetModel
  constructor: (widget, @dashboard) ->
    @parent = @dashboard.uuid
    if widget.style is null
      widget.style = {}
    @device = widget.device
    @key = widget.key
    extendObservable(@, {
      overrideStyle: widget.overrideStyle or no
      label: widget.label
      type: widget.type
      style: if widget.overrideStyle then widget.style else @dashboard.widgetStyle
      widgetStyle: computed(->
        if @overrideStyle
          backgroundColor: @style.backgroundColor
          color: @style.color
          borderRadius: @style.borderRadius
        else
          @dashboard.widgetStyle
      )

      toggleStyleOverride: action(->
        if !@overrideStyle
          @style = @dashboard.widgetStyle
        @overrideStyle = !@overrideStyle
      )

    })




export widgetSchema =
  factory: ((context) =>
    {args, json, parentContext} = context
    if !widgetStore.widgets.has(json.uuid)
      store = if args?.dashboard? then args.dashboard else parentContext.target
      widgetStore.widgets.set(json.uuid, new WidgetModel(json, store))
    return widgetStore.widgets.get(json.uuid)
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
