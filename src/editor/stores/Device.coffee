import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import Settings from './settings/Settings'

class UserDevice extends Settings
  constructor: (device) ->
    super()
    @ip = device.ip
    @type = device.type
    @height = Math.max(device.height, device.width)
    @width = Math.min(device.height, device.width)
    extendObservable @, {
      name: device.name
      settingsID: device.settingsID
      defaultDashboardId: device.defaultDashboardId or null
      dashboards: observable.map({})
      widgets: observable.map({})





      deserialize: action((props) ->
        dashboards = props.dashboards ?= {}
        widgets = props.widgets ?= {}
        runInAction(=>
          @name = props.name
          @defaultDashboardId = props.defaultDashboardId
          @dashboards.replace(dashboards)
          @widgets.replace(widgets)

        )
      )


    }
    @save()



  serialize: (to_json = no) ->
    return mobx.toJS({
      ip: @ip
      name: @name
      dashboards: mobx.toJS(if to_json then @dashboards.values() else @dashboards)
      widgets: mobx.toJS(if to_json then @widgets.values() else @widgets)
      defaultDashboardId: @defaultDashboardId
    })






    
export default UserDevice



