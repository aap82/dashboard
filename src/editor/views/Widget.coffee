{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'

SwitchWidget = require '../../widgets/SwitchWidget'
ButtonWidget = require '../../widgets/ButtonWidget'


Widget = observer(({widget, dashboard, deviceStore}) ->
  device = if widget.device is '' then 'office-cold' else widget.device
  div id: widget.id, style: dashboard.baseWidgetStyle, className: 'base-widget z-depth-' + dashboard.widgetCardDepth, ->
    if widget.type is 'ButtonWidget'
      crel ButtonWidget, widget: widget, device: deviceStore.devices["#{device}"]
    else
      crel SwitchWidget, widget: widget, device: deviceStore.devices["#{device}"]

)



module.exports = inject('deviceStore')(Widget)