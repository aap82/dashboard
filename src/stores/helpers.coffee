
setStyles = (model, styles) ->
  model.style[key] = value for key, value of styles if model.style[key]?
  model

checkObjectForString = (obj, key) ->
  if typeof obj[key] is 'string' then obj[key] = JSON.parse(obj[key])
  obj

exports.typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

exports.setDashboardProps = (dashboard, props) =>
  for key, value of props when dashboard[key]?
    checkObjectForString props, key if key in ['widgets', 'devices']
    switch key
      when 'widgets' then props.dashboard
      when 'style' then setStyles(dashboard, props.style)
      else dashboard[key] = props[key]
  dashboard

exports.setWidgetProps = (widget, props) ->
  for key, value of props when widget[key]?
    checkObjectForString props, key if key in ['attrNames']
    switch key
      when 'style' then setStyles(widget, value)
      else widget[key] = value
  widget


exports.setDeviceProps = (device, props) ->
  for key, value of props when device[key]?
    checkObjectForString props, key if key in ['details']
    device[key] = props[key]
  device

exports.clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = clone obj[key]

  return newInstance

exports.addChainedAttributeAccessor = (obj, propertyAttr, attr) ->
  obj[attr] = (newValues...) ->
    if newValues.length == 0
      obj[propertyAttr][attr]
    else
      obj[propertyAttr][attr] = newValues[0]
      obj