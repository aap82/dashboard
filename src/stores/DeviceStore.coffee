import { extendObservable, observable, action, runInAction} from 'mobx'


class DeviceStore
  constructor: ->
    @stream = null
    @devices = {}
    extendObservable @, {
      states:  observable.map({})
      addDevice: action((device) -> @devices[device.id] = device)
      addDeviceState: action((deviceState) -> @states.merge(deviceState))
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

export default  deviceStore