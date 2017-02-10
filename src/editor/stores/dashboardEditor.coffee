t = require '../LeftPanel/buttons/types'
{extendObservable, action, computed, toJS, observable} = require 'mobx'
WidgetEditor = require './widgetEditor'
ButtonContainer = require '../components/ButtonContainer'
hexToRgba = require('hex-rgba')
Dashboard = require './DashboardView'
EditableWidget = require './Widget'
EditableObject = require './EditableObject'
DashboardModel = require '../../models/Dashboard'
buttons = require '../LeftPanel/buttons/buttons'

dashboard = DashboardModel.create()
dashboard.widgetProps =
  backgroundColor: "#fff"
  backgroundAlpha: 100
  fontColor: "#fff"
  borderRadius: 2
  cardDepth: 2

widgetProps =
  backgroundColor: "#fff"
  backgroundAlpha: 100
  fontColor: "#fff"
  borderRadius: 2
  cardDepth: 2
class DashboardHistory
  class Memento
    constructor:  ->
      @dashboard = {}
  constructor:  ->
    @dashboard = {}
  save: (dashboard) ->
    console.log dashboard
    memento = new Memento @dashboard
    @dashboard = dashboard
    memento
  restore: (memento) ->
    @dashboard = memento.dashboard
    return



class DashboardEditor extends Dashboard


  constructor:  ->
    @history = new DashboardHistory({})
    @createId = 500
    @devices = []
    @newLayout = []
    super()
    extendObservable @, {
      buttons: {}
      isDashboardStyleDefault: no
      isWidgetStyleDefault: no
      create: action((title, type) ->
        @createId++
        dashboard = DashboardModel.create(title, type)
        dashboard.widgetProps = widgetProps
        dashboard.id = @createId
        @setProps(dashboard)
        dashboard
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
      addWidget: action(=>
        @layouts.replace(@newLayout)
        WidgetEditor.key++
        @layouts.push WidgetEditor.layout
        @devices.push widget.device.id
        @widgets.push widget
        WidgetEditor.reset()
      )

      startEditing: action(=>
        for key, button of @buttons
          @buttons[key].enable() if button.enableOnEdit
          @buttons[key].show() if button.showOnEdit
          @buttons[key].hide() if button.hideOnEdit
        @isEditing = yes
        return
      )

      stopEditing: action(=>
        for key, button of @buttons
          @buttons[key].disable() if button.enableOnEdit
          @buttons[key].hide() if button.showOnEdit
          @buttons[key].show() if button.hideOnEdit
        @isEditing = no
        return
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

