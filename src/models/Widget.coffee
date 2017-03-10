{getDefaultModelSchema, setDefaultModelSchema, object, createModelSchema, createSimpleSchema,identifier} = require 'serializr'

attrNamesMap = createSimpleSchema({"*": yes})
export deviceSchema = createSimpleSchema({
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
  attrNames: object(attrNamesMap)
  label: yes
  cardDepth: yes
  type: yes

})



export class WidgetModel
  constructor: ->


export widgetSchema =
  factory: ((context) -> new WidgetModel)
  props:
    key: identifier()
    uuid: identifier()
    props: object(propsSchema)
    style: object(styleSchema)
    device: object(deviceSchema)


