import {extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import Color from 'color'

import uuidV4 from 'uuid/v4'





class Dashboard
  constructor: ->
    extendObservable @, {
      device: null
      uuid: ''
      title: ''
      setDevice: action((device) ->
        runInAction(=>
          @device = device
          @uuid = ''
          @title = ''
        )
      )

      deviceIP: computed(-> if @device? then @device.ip else null)
      useDefaults: observable.object({
        grid: yes
        widgetColor: yes
        widgetFont: yes
      })

      overrideSettingDefault: action((prop, value) -> @useDefaults[prop] = value if @useDefaults[prop]?)
      resetDefaults: action(->
        @useDefaults =
          grid: yes
          widgetColor: yes
          widgetFont: yes

      )



      initNew: action('initialize dashboard', (title) ->
        runInAction(=>
          @uuid = uuidV4()
          @device.settings.active = 'default'
          @title = title
          @resetDefaults()

        )

      )


      deserialize: action('deserialize dashboard', (device, props) ->
        runInAction(=>

          @title = props.title or ''
          @uuid = props.uuid or null
          @useDefaults = if props.useDefaults? then  @resetDefaults()
        )
      )
      serialize: action('serialize dashboard', ->
        uuid: @uuid
        title: @title
        deviceIP: @deviceIP
        useDefaults: toJS(@useDefaults)
      )

    }


dashboard = new Dashboard


export default dashboard