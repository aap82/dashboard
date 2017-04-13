import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Panel from './Panel'
import Dashboard from './Dashboard'
import Settings from './Settings'
import uuidV4 from 'uuid/v4'



class Editor
  constructor: (settings) ->
    @settingsStore= settings
    extendObservable @, {
      device: null
      zoom: 1
      isAddingDashboard: no
      isEditing: no
      selectedDashboardID: ''
      activeSettingsID: ''
      getDashboards: action(->return @device.dashboards)
      settings: computed(->@settingsStore.store.get(@activeSettingsID))
      isDirty: computed(-> @settings?.isDirty or @device.isDirty)


      selectDevice: action((device) ->
        runInAction(=>
          @device = device
          @activeSettingsID = device.settingsID
          @selectedDashboardID = ''
        )
      )
      selectDashboard: action((dash) ->
        runInAction(=>
          @activeSettingsID = dash.settingsID
          @selectedDashboardID = dash.uuid
        )
      )
      createDashboard: action("Create Dashboard", (title) ->
        runInAction(=>
          id = uuidV4()
          @device.dashboards.set(id, {
            title: title
            uuid: id
            deviceIP: @device.ip
            settingsID: @device.settingsID
          })
          @selectDashboard(uuid: id, settingsID: @device.settingsID)
          @isAddingDashboard = no
        )
      )
      deleteDashboard: action("Delete Dashboard", ->
        runInAction(=>
          @activeSettingsID = @device.settingsID
          @device.dashboards.delete(@selectedDashboardID)
          @selectedDashboardID = ''
        )
      )



      restore: action(->
        runInAction(=>
          @settings.restore()
          @device.restore()
        )

      )
      save: action(->
        runInAction(=>
          @settings.save()
          @device.save()
        )
      )



    }


editor = new Editor(Settings, Dashboard)

export default editor
