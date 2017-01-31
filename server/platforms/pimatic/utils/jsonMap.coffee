DataTransform = require("node-json-transform").DataTransform
keyBy = require 'lodash.keyby'

exports.getTransformedObj = (json) ->

  dataTransform = DataTransform(json, baseMap)
  result = dataTransform.transform()
  return result



finalProcessing = (arr) ->
  result =
    devices: []
    lights: []
    buttons: []
    sensors: []
    thermostats: []
  for device in arr
    result.devices.push device.id
    switch device.type
      when 'light' then result.lights.push device.id
      when 'sensor' then result.sensors.push device.id
      when 'button' then result.buttons.push device.id
  return {
    entities: keyBy(arr, 'id')
    results: result
  }







baseMap =
  list: 'devices'
  item:
    id: 'id'
    name: 'name'
    type: ''
    deviceClass: 'config.class'
    deviceClassType: 'template'

    actions: 'actions'

    state: ''
    stateType: ''
    attributes: 'attributes'
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
      when item.deviceClassType.slice(0, 3) is 'hue' then 'dimmer'
      else
        item.deviceClassType




    for attr in item.attributes
      if attr.name in ['state', 'presence', 'contact']
        item.state = attr.value
        item.stateType = attr.type









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