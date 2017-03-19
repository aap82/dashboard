{crel} = require 'teact'
SwitchWidget = require './SwitchWidget'
ButtonWidget = require './ButtonWidget'




exports.getWidget = (type) =>
  switch type
    when 'switchWidget' then return SwitchWidget
    when 'buttonWidget'then return ButtonWidget
    else null

