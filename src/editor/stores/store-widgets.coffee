SwitchWidgetProps = require '../../widgets/SwitchWidget/props'
ButtonWidgetProps = require '../../widgets/ButtonWidget/props'
class WidgetStore
  constructor: ->
    @switchWidget = SwitchWidgetProps
    @buttonWidget = ButtonWidgetProps
    @widgetTypes = [
      {id: 'switchWidget', types: @switchWidget.types, name: 'Switch Widget', widget: @switchWidget}
      {id: 'buttonWidget', types: @buttonWidget.types, name: 'Button Widget', widget: @buttonWidget }
    ]



widgetStore = new WidgetStore

module.exports = widgetStore