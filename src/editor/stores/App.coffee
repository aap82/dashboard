import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Color from 'color'
import UserDevice from './Device'
import Dashboard from './Dashboard'
import Settings from './Settings'
import Editor from './Editor'

export class AppStore
  constructor: (editor, settings, dashboard) ->
    @editor = editor
    @dashboard = dashboard
    @settings = settings
    extendObservable @, {
      device: null
      devices: []

      isSettingsPanelVisible: yes
      isToolBarVisible: computed(-> @dashboard.uuid isnt null)
      selectedDashboardId: ''

      selectDevice: action((device) ->
        runInAction(=>
          @settings.create(device) if !device.settingsID?
          @device = device
          @editor.selectDevice(@device)

        )
      )

      init: action((devices) ->
        @devices = (new UserDevice(device) for device in devices)
      )



    }








export appStore = new AppStore(Editor, Settings, Dashboard)

export default appStore

