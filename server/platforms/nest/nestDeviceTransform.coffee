actions = require './actions'
attributes = require './attributes'
DataTransform = require('node-json-transform').DataTransform
exports.getTransformedObj = (json) ->
  _dataTransform = DataTransform(json, baseMap)
  _result = _dataTransform.transform()
  return _result

#item.deviceId = paramCase(item.name)
baseMap =
  list: 'devices'
  item:
    deviceId: 'device_id'
    name: 'name'
    type: ''
    state:
      last_connection: 'last_connection'
      is_online: 'is_online'
      has_leaf: 'has_leaf'
      temperature_scale: 'temperature_scale'
      target_temperature_f: 'target_temperature_f'
      target_temperature_c: 'target_temperature_c'
      target_temperature_high_f: 'target_temperature_high_f'
      target_temperature_high_c: 'target_temperature_high_c'
      target_temperature_low_f: 'target_temperature_low_f'
      target_temperature_low_c: 'target_temperature_low_c'
      away_temperature_high_f: 'away_temperature_high_f'
      away_temperature_high_c: 'away_temperature_high_c'
      away_temperature_low_f: 'away_temperature_low_f'
      away_temperature_low_c: 'away_temperature_low_c'
      ambient_temperature_f: 'ambient_temperature_f'
      ambient_temperature_c: 'ambient_temperature_c'
      humidity: 'humidity'
      hvac_mode: 'hvac_mode'
      hvac_state: 'hvac_state'


  each: (item) ->
    item.platform = 'nest'
    item.id = 'nest-thermostat-' + item.deviceId
    item.type = 'nest-thermostat'
    item.actions = actions
    item.attributes = attributes
