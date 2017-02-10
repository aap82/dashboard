{crel} = require 'teact'
SwitchWidget = require './SwitchWidget'
ButtonWidget = require './ButtonWidget'




exports.getWidget = ({label, attrNames, device, type}, state) =>
  console.log label
  props =
    label: label
    attrNames: attrNames
    device: device
    type: type
    state: state
  switch type
    when 'SwitchWidget'
      crel SwitchWidget, props
    when 'ButtonWidget'
      crel ButtonWidget, props
    else null

