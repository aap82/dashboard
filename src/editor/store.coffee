import editor from './stores/editorStore'
import ViewState from './stores/viewStore'

import widgets from './stores/widgetsStore'
import DeviceStore from '../stores/DeviceStore'

import Time from '../stores/Time'
import modalStore from './stores/modalsStore'
gqlFetch = require('../utils/fetch')('/graphql')

export configureStores = (data) ->
  console.log data
  editor.loadUserDevices(data.userDevices)
  editor.dashboards.replace( data.dashboards)
  deviceStates = if data.deviceStates.states? then JSON.parse(data.deviceStates.states) else []
  DeviceStore.states.replace(deviceStates)
  DeviceStore.addDevice(device) for device in data.devicesSetup
  widgets.devices = DeviceStore.devices
  widgets.platforms = JSON.parse(data.devicePlatforms.platforms)
  return {
    viewState: new ViewState({
      modal: modalStore
      editor: editor
      fetch: gqlFetch
      dashboards: data.dashboards
    })
    editor: editor
    widgets: widgets
    modal: modalStore
    deviceStore: DeviceStore
    weather: data.weather
    time: Time


  }

