import SwitchWidgetProps from '../../widgets/SwitchWidget/props'
import ButtonWidgetProps from '../../widgets/ButtonWidget/props'
class WidgetStore
  constructor: ->
    @switchWidget = SwitchWidgetProps
    @buttonWidget = ButtonWidgetProps
    @widgetTypes = [
      {id: 'switchWidget', types: @switchWidget.types, name: 'Switch Widget', widget: @switchWidget}
      {id: 'buttonWidget', types: @buttonWidget.types, name: 'Button Widget', widget: @buttonWidget }
    ]



widgetStore = new WidgetStore

export default widgetStore