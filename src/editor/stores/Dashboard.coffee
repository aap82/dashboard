import {extras, extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import Color from 'color'
import uuidV4 from 'uuid/v4'





class DashboardStore
  constructor: ->
    extendObservable @, {
      backups: observable.map({})
      backup: computed(-> @backups.get(@uuid))
      device: null
      uuid: ''
      title: ''
      settingsID: null
      setDevice: action((device) ->
        runInAction(=>
          @device = device
          @uuid = null
          @title = null
          @settingsID = device.settingsID
        )
      )

      deviceIP: computed(-> if @device? then @device.ip else null)
      initNew: action('initialize dashboard', (title) ->
        runInAction(=>
          @uuid = uuidV4()
          @title = title
          @backups.set(@uuid, @serialize())
        )
      )
      deserialize: action('deserialize dashboard', (props) ->
        runInAction(=>
          if !@backups.has(props.uuid)
            @backups.set(props.uuid, props)
          @uuid = props.uuid
          @title = props.title
          @settingsID = props.settingsID
        )
      )
      serialize: action('serialize dashboard', ->
        uuid: @uuid
        title: @title
        deviceIP: @deviceIP
        settingsID: @settingsID
      )

      isDirty: computed(->
        if @uuid is '' or @uuid is null
          return no
        else
          console.log @backup, console.log @title
          !extras.deepEqual(toJS(@backup), @serialize())
      )





    }


dashboard = new DashboardStore


export default dashboard


#
#Dashboard = (id, title, deviceIP, settingsID) ->
#  extendObservable @, {
#    uuid: id
#    title: title
#    deviceIP: deviceIP
#    settingsID: settingsID
#
#    serialize: action(->
#      uuid: @uuid
#      title: @title
#      deviceIP: @deviceIP
#      settingsID: @settingsID
#    )
#  }
#
