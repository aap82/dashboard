import mobx,{extras, extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {GridSettings, WidgetStyleSettings, WidgetFontSettings} from './DashboardSettings'
import {extend} from 'lodash'
import uuidV4 from 'uuid/v4'



DashboardSettings = (settings = {}, device = {}) ->
  @uuid = settings.uuid or device.settingsID
  @type = settings.type or device.type
  @height = settings.height or device.height
  @width = settings.width or device.width
  extendObservable @, {
    grid: new GridSettings(@type, @height, @width, settings)
    widgetStyle: new WidgetStyleSettings(settings)
    widgetFont: new WidgetFontSettings(settings)


    serialize: action(->
      uuid: @uuid
      height: @height
      width: @width
      type: @type
      grid: @grid.serialize()
      widgetStyle: @widgetStyle.serialize()
      widgetFont: @widgetFont.serialize()
    )


    save: action(->
      runInAction(=>
        @grid.save() if @grid.isDirty
        @widgetStyle.save() if @widgetStyle.isDirty
        @widgetFont.save() if @widgetFont.isDirty
      )

    )

    restore: action(->
      runInAction(=>
        @grid.restore() if @grid.isDirty
        @widgetStyle.restore() if @widgetStyle.isDirty
        @widgetFont.restore() if @widgetFont.isDirty
      )
    )


    isDirty: computed(->
      if @grid.isDirty or @widgetStyle.isDirty or @widgetFont.isDirty
        return yes
      else
        return no
    )
  }


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






