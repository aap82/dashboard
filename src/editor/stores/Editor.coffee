import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Panel from './Panel'
import Settings from './Settings'
import uuidV4 from 'uuid/v4'
import Widget from './Widget'


class Editor
  constructor: (settings) ->
    @settingsStore= settings
    @unsavedDashboards = []
    extendObservable @, {
      device: null
      dashboard: null
      settings: null
      widgets: observable.map({})
      zoom: 1
      isAddingDashboard: no
      isEditing: no
      isDirty: computed(-> @settings.isDirty or @device.isDirty)

      changeSettings: action((settingsID) -> @settings = @settingsStore.store.get(settingsID))

      selectDevice: action((device) ->
        runInAction(=>
          if device is @device
            @device = null
          else
            @settingsStore.create(device) if !device.settingsID?
            @changeSettings(device.settingsID)
            @device = device
          @dashboard = null
        )
      )
      selectDashboard: action((dash) ->
        console.log dash
        runInAction(=>
          if dash is @dashboard
            @changeSettings @device.settingsID
            @dashboard = null
          else
            @changeSettings dash.settingsID
            @dashboard = dash
            @createWidget()


        )
      )
      createDashboard: action("Create Dashboard", (title, settingsID = @device.settingsID) ->
        runInAction(=>
          id = uuidV4()
          @unsavedDashboards.push id
          @device.dashboards.set(id, {
            title: title
            uuid: id
            deviceIP: @device.ip
            settingsID: settingsID
            widgets: []
          })
          @selectDashboard(@device.dashboards.get(id))
          @isAddingDashboard = no
        )
      )
      copyDashboard: action("Copy Dashboard", ->
        runInAction(=>
          @createDashboard(
            @dashboard.title + ' - Copy'
            @dashboard.settingsID
          )

        )
      )
      deleteDashboard: action("Delete Dashboard", ->
        runInAction(=>
          @changeSettings @device.settingsID
          @device.dashboards.delete(@dashboard.uuid)
          @dashboard = null
        )
      )

      restore: action(->
        runInAction(=>
          if @dashboard?.uuid in @unsavedDashboards
            @dashboard = null
          @changeSettings(@device.settingsID) if @settings.uuid isnt @device.settingsID
          @settings.restore()
          @device.restore()
          @unsavedDashboards = []
        )
      )
      save: action(->
        runInAction(=>
          @settings.save()
          @device.save()
          @unsavedDashboards = []
        )
      )



      createWidget: action("Create Widgets", ->
        runInAction(=>
          return if @dashboard is null
          id = uuidV4()
          widget = new Widget({
            uuid: id
            type: 'Switch'
            layout:
              x: 10
              y: 10
              h: 100
              w: 100
              minH: 50
              minW: 50
          }, @settings, @settings)
          console.log widget
        )


      )

    }


  toJS: =>
    device: @device.serialize(yes)
    settings: @settings.serialize()



editor = new Editor(Settings)

export default editor
