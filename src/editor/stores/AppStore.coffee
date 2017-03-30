import {extendObservable, observable, computed, action} from 'mobx'
import {Dashboard} from './Dashboard'
import Color from 'color'







export class AppStore
  constructor: ->
    extendObservable @, {
      dashboards: observable.shallowMap({})
      devices: observable.shallowMap({})
      init: action((devices, dashboards) ->
        @dashboards.set(dashboard.uuid, new Dashboard(dashboard)) for dashboard in dashboards
        for device in devices
          device.dashboards = (d.uuid for d in device.dashboards)
          @devices.set(device.ip, device)
      )


    }




export appStore = new AppStore

export default appStore

