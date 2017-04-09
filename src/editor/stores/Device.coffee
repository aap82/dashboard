import mobx, {extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import SettingsStore from './Settings'

class UserDevice
  constructor: (store, device) ->
    @store = store
    @ip = device.ip
    @type = device.type
    @settings = new SettingsStore(device)
    extendObservable @, {
      name: device.name
      location: device.location or ''
      dashboards: device.dashboards or []
      defaultDashboardId: device.defaultDashboardId or null
      isSelected: computed(-> @store.dashboard?.device?.ip is @ip)


      serialize: action(->
        ip: @ip
        name: @name
        location: @location
        dashboards: toJS(@dashboards)
        defaultDashboardId: @defaultDashboardId
        settings: mobx.toJS(@settings.getDefaultSettings())

      )


    }



    
export default UserDevice







#
#class Devices
#
#  constructor: ->
#    extendObservable @, {
#      selectedDevice: ''
#      devices: []
#    }
#
#  @init: (devices) =>
#    @devices = (device for device in devices)