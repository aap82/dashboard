{ extendObservable, observable, action, runInAction} = require 'mobx'


class DeviceStore
  constructor: ->
    @stream = null
    extendObservable @, {
      states:  observable.map({})
      addDeviceState: action((device) -> @states.merge(device))
      handleDeviceUpdate: action((e) =>
        data = JSON.parse(e.data)
        @states.merge(update) for update in data
      )
      subscribe: action(->
        runInAction(=>
          @stream = new EventSource("/updates/#{@states.keys()}")
          @stream.addEventListener 'update', @handleDeviceUpdate
        )
      )
    }


deviceStore = new DeviceStore()

module.exports =  deviceStore