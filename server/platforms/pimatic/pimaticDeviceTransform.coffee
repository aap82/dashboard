DataTransform = require("node-json-transform").DataTransform
exports.getTransformedObj = (json) ->
  _dataTransform = DataTransform(json, baseMap)
  _result = _dataTransform.transform()
  return _result


baseMap =
  list: 'devices'
  item:
    deviceId: 'id'
    name: 'name'
    type: ''
    actions: 'actions'
    attributes: 'attributes'
    extraInfo:
      deviceClass: 'config.class'
      deviceClassType: 'template'


  operate: [
    {
      run: (ary) ->
        DataTransform({ list: ary }, attributesMap).transform()
      on: 'attributes'
    }
  ]
  each: (item) ->
    item.platform = 'pimatic'
    item.id = 'pimatic-' + item.deviceId
    item.type = switch
      when item.extraInfo.deviceClassType.slice(0, 3) is 'hue' then 'dimmer'
      else
        item.extraInfo.deviceClassType
    if item.type in ['switch', 'dimmer']
      state = null
      for attr in item.attributes
        if attr.name is 'state'
          state = attr
        if state isnt null then break
      item.attributes.push
        type: attr.type
        name: 'on'
        unit: attr.unit
        value: attr.value




attributesMap =
  list: 'list'
  item:
    type: 'type'
    name: 'name'
    unit: 'unit'
    value: 'value'
#  operate: [
#    {
#      run: (name) -> if name is 'state' then 'on' else name
#      on: 'name'
#    }
#
#
#  ]











#module.exports = baseMap