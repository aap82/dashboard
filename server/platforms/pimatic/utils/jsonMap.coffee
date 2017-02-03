DataTransform = require("node-json-transform").DataTransform
exports.getTransformedObj = (json) ->

  dataTransform = DataTransform(json, baseMap)
  result = dataTransform.transform()
  return result


baseMap =
  list: 'devices'
  item:
    id: 'id'
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
    item.type = switch
      when item.extraInfo.deviceClassType.slice(0, 3) is 'hue' then 'dimmer'
      else
        item.extraInfo.deviceClassType



attributesMap =
  list: 'list'
  item:
    type: 'type'
    value: 'value'
    name: 'name'
    unit: 'unit'
  operate: [
    {
      run: (val) -> "#{val}"
      on: 'value'
    }


  ]









#module.exports = baseMap