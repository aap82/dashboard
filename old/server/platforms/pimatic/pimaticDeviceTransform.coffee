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
      item.state[attr.name] = attr.value for attr in item.attributes






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