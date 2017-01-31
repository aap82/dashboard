{extendObservable, action, computed, asMap, toJS} = require 'mobx'
SwitchWidgetProps = require '../../widgets/SwitchWidget/props'
ButtonWidgetProps = require '../../widgets/ButtonWidget/props'
class WidgetStore
  constructor: ->
    @SwitchWidget = SwitchWidgetProps
    @ButtonWidget = ButtonWidgetProps
    @widgets = [
      'SwitchWidget'
      'ButtonWidget'
    ]



widgetStore = new WidgetStore()

module.exports = widgetStore