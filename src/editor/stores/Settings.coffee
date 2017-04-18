import mobx,{extras, extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'

import {extend} from 'lodash'
import uuidV4 from 'uuid/v4'
import DashboardSettings from './settings/Dashboard'


class SettingsStore
  constructor: ->
    extendObservable @, {
      store: observable.map({})

      load: action((setting) ->
        return if @store.has(setting.uuid)
        @store.set(setting.uuid, new DashboardSettings(setting, null))
      )

      create: action((device) ->
        runInAction(=>
          device.settingsID = uuidV4()
          @store.set(device.settingsID, new DashboardSettings(null, device))
        )
      )





    }

settingsStore = new SettingsStore

export default settingsStore






