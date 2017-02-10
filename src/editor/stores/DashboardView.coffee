{extendObservable, computed, toJS, action, isObservableArray, isObservable} = require 'mobx'

EditableObject = require './EditableObject'
DashboardModel = require '../../models/Dashboard'

dashboard = DashboardModel.create()
dashboard.widgetProps =
  backgroundColor: "#fff"
  backgroundAlpha: 100
  fontColor: "#fff"
  borderRadius: 2
  cardDepth: 2



class Dashboard extends EditableObject
  constructor: ->
    extendObservable(@, dashboard)
    super()
    extendObservable @, {
      dashboardStyle: computed(-> toJS(@style))
      widgetStyleProps: computed(->
        backgroundColor: hexToRgba(@widgetProps.backgroundColor, @widgetProps.backgroundAlpha)
        borderRadius: @widgetProps.borderRadius
        color: @widgetProps.color
      )
    }







#dashboard = new DashboardView()
module.exports = Dashboard
