import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Color from 'color'
import UserDevice from './Device'
import Dashboard from './Dashboard'

export class AppStore
  constructor: (dashboard) ->
    @dashboard = dashboard
    extendObservable @, {
      device: null
      devices: []

      selectedDashboardId: computed(-> @dashboard.uuid)

      selectDevice: action((device) ->
        runInAction(=>
          @device = device
          @dashboard.setDevice(device)

        )
      )
      selectDashboard: action((dash) -> @dashboard.deserialize(@device, dash))

      init: action((devices) ->
        @devices = (new UserDevice(@, device) for device in devices)
      )



    }








export appStore = new AppStore(Dashboard)

export default appStore

