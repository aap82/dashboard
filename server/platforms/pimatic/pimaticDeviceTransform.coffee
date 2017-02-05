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
    other:
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
      when item.other.deviceClassType.slice(0, 3) is 'hue' then 'dimmer'
      else
        item.other.deviceClassType
    if item.type not in ['buttons', 'device']
      item.state = {}
      for attr in item.attributes
        item.state[attr.name] = attr.value
      if item.type in ['switch', 'dimmer'] and attr.name is 'state'
          item.state.on = attr.value
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