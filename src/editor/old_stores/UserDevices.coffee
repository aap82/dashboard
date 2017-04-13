import {extendObservable, observable, computed, action} from 'mobx'

class UserDevices
  constructor: ->
    extendObservable @, {
      devices: observable.map({})


      load: action('Load Devices', (devices) -> @devices.set(device.ip, observable.map(device)) for device in devices)
      add: action('Add Device', (device) -> @devices.set(device.ip, observable.map(device)))




    }


userDevices = new UserDevices
export default userDevices