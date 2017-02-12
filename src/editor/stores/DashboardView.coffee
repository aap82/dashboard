{extendObservable, computed, toJS, action, isObservableArray, isObservable} = require 'mobx'

EditableObject = require './EditableObject'
DashboardModel = require '../../models/Dashboard'
hexToRgba = require 'hex-rgba'
dashboard = DashboardModel.create()
dashboard.widgetProps =
  backgroundColor: "#ff525b"
  backgroundAlpha: 100
  color: "#fff"
  borderRadius: 2
  cardDepth: 2



class Dashboard extends EditableObject
  constructor: ->
    @model = toJS(dashboard)
    extendObservable(@, dashboard)
    super()
    extendObservable @, {
      widgetStyleProps: computed(->
        backgroundColor: hexToRgba(@widgetProps.backgroundColor, @widgetProps.backgroundAlpha)
        borderRadius: @widgetProps.borderRadius
        color: @widgetProps.color
      )
    }







#dashboard = new DashboardView()
module.exports = Dashboard
