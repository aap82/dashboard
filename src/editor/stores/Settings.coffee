
import mobx,{extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {GridSettings, WidgetColor, WidgetFontStyles} from './DashboardSettings'


class SettingsStore
  constructor: (device) ->
    @height = Math.max(device.height, device.width)
    @width = Math.min(device.height, device.width)
    extendObservable @, {
      active: 'default'
      grid: computed((-> @dashboard.get('default').grid), compareStructural: yes)
      widgetColor: computed((-> @dashboard.get('default').widgetColor), compareStructural: yes)
      widgetFont: computed((-> @dashboard.get('default').widgetFont), compareStructural: yes)


      activeSettings: computed(->
        grid: @dashboard.get(@active)
        widgetFont: @dashboard.get(@active)
        widgetColor: @dashboard.get(@active)
      )

      dashboard: observable.map {
        default:
          grid: new GridSettings(device.type, @height, @width, device.defaults?.grid or null)
          widgetColor: new WidgetColor(device.defaults?.widgetColor or null)
          widgetFont: new WidgetFontStyles(device.defaults?.widgetFont or null)
      }, compareStructural: yes

      getDefaultSettings: action(->
        default:
          grid: @dashboard.get('default').grid.serialize()
          widgetColor: @dashboard.get('default').widgetColor.serialize()
          widgetFont: @dashboard.get('default').widgetFont.serialize()
      )

      getCurrentSettings: action(->
        grid: @grid.serialize()
        widgetColor: @widgetColor.serialize()
        widgetFont: @widgetFont.serialize()

      )

      serialize: action(-> mobx.toJS(mobx.toJS(@dashboard)))




    }



export default SettingsStore






