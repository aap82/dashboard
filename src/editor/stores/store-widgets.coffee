{extendObservable, action, computed, asMap, toJS} = require 'mobx'
SwitchWidgetProps = require '../../widgets/SwitchWidget/props'
ButtonWidgetProps = require '../../widgets/ButtonWidget/props'
class WidgetStore
  constructor: ->
    @switchWidget = SwitchWidgetProps
    @buttonWidget = ButtonWidgetProps
    @widgetTypes = [
      {id: 'switchWidget', types: @switchWidget.types, name: 'Switch Widget', attrNames: @switchWidget.attrNamesMap, widget: @switchWidget}
      {id: 'buttonWidget', types: @buttonWidget.types, name: 'Button Widget', attrNames: @buttonWidget.attrNamesMap, widget: @buttonWidget }
    ]



widgetStore = new WidgetStore()

module.exports = widgetStore