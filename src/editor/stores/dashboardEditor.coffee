t = require '../LeftPanel/buttons/types'
{extendObservable, action, toJS} = require 'mobx'
WidgetEditor = require './widgetEditor'
ButtonContainer = require '../components/ButtonContainer'
Dashboard = require './DashboardView'
buttons = require '../LeftPanel/buttons/buttons'
{createViewModel} = require('mobx-utils')
widgetProps =
  backgroundColor: "#ff525b"
  backgroundAlpha: 100
  color: "#fff"
  borderRadius: 2
  cardDepth: 2

class DashboardEditor extends Dashboard
  constructor:  ->
    super()
    @createId = 500
    @devices = []
    @newLayout = []
    extendObservable @, {
      buttons: {}
      isDashboardStyleDefault: no
      isWidgetStyleDefault: no
      create: action((title, type) ->
        @createId++

        @initDashboard(@createId, title, type)


#        console.log model

      )
      loadDashboard: action((id) ->
        dashboard = @getDashboardById(id)
        console.log dashboard
      )
      close: action(->
        @layouts.clear()
        @widgets.clear()
        @newLayout = []
        @id = -1
      )

      deleteWidget: action((widget) ->
        WidgetEditor.stopEditing()
        @widgets.remove(widget)
      )
      addWidget: action(->
        @viewModel.layouts.replace(@newLayout)
        widget = WidgetEditor.getNewWidget(widgetProps)
        layout = WidgetEditor.layout
        @layouts.push layout
        @widgets.push widget
        @setProp('layouts', @layouts)
        @setProp('widgets', @widgets)

        WidgetEditor.reset()
      )

      startEditing: action(=>
#        for key, button of @buttons
#          @buttons[key].enable() if button.enableOnEdit
#          @buttons[key].show() if button.showOnEdit
#          @buttons[key].hide() if button.hideOnEdit
        @isEditing = yes
        return
      )

      stopEditing: action(=>
#        for key, button of @buttons
#          @buttons[key].disable() if button.enableOnEdit
#          @buttons[key].hide() if button.showOnEdit
#          @buttons[key].show() if button.hideOnEdit
        @isEditing = no
        return
      )

      handleButtonPress: action((id) ->
        console.log id
        switch id
          when t.INC_CARD_DEPTH
            break if @viewModel.widgetProps.cardDepth is 5
            value = @viewModel.widgetProps.cardDepth
            value++
            @setWidgetProp('cardDepth', value)
            break
          when t.DEC_CARD_DEPTH
            break if @viewModel.widgetProps.cardDepth is 0
            value = @viewModel.widgetProps.cardDepth
            value--
            @setWidgetProp('cardDepth', value)
            break
          when t.INC_BORDER_RADIUS
            value = @viewModel.widgetProps.borderRadius
            value++
            @setWidgetProp('borderRadius', value)
            break
          when t.DEC_BORDER_RADIUS
            break if @viewModel.widgetProps.borderRadius is 0
            value = @viewModel.widgetProps.borderRadius
            value--
            @setWidgetProp('borderRadius', value)
            break


      )


    }

  toJSON: =>
    dashboard = JSON.parse JSON.stringify(toJS(@))
    dashboard.devices = []
    dashboard.devices.push widget.device.id for widget in dashboard.widgets when widget.device.id not in dashboard.devices
    dashboard[key] = JSON.stringify(value) for key, value of dashboard when typeof value not in ['string', 'number']
    dashboard.widgetEditor = JSON.stringify(@widgetProps)
    return dashboard



dashboardEditor = new DashboardEditor()



module.exports =  dashboardEditor

