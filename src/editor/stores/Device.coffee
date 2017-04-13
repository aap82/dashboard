import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {Settings} from './DashboardSettings'
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
      location: device.location or ''
      dashboards: observable.map({})
      defaultDashboardId: device.defaultDashboardId or null




      deserialize: action((props) ->
        dashboards = props.dashboards ?= {}
        runInAction(=>
          @name = props.name
          @location = props.location
          @defaultDashboardId = props.defaultDashboardId
          @dashboards.replace(dashboards)
        )
      )


    }
    @save()
  serialize: ->
    test = {
      ip: @ip
      name: @name
      location: @location
      dashboards: mobx.toJS(@dashboards)
      defaultDashboardId: @defaultDashboardId
    }
    return test






    
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