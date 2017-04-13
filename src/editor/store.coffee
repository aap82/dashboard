import DeviceStore from '../stores/DeviceStore'
import {Devices} from './stores/Device'
#import Time from '../stores/Time'
import modalStore from './old_stores/modalsStore'
import userDevices from './old_stores/UserDevices'
import appStore from './stores/App'
import Editor from './stores/Editor'
import Panel from './stores/Panel'

export configureStores = (data) ->
  console.log data
  appStore.init(data.userDevices)
  deviceStates = if data.deviceStates.states? then JSON.parse(data.deviceStates.states) else []
  DeviceStore.states.replace(deviceStates)
  DeviceStore.addDevice(device) for device in data.devicesSetup
  return {
    app: appStore
    panel: Panel
    modal: modalStore
    editor: Editor
    deviceStore: DeviceStore
    weather: data.weather
  }

