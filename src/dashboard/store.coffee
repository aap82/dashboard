import deviceStore from './stores/DeviceStore'
import viewStore from './stores/ViewStore'

export configureStores = (data) ->
  deviceStore.states.replace(data.deviceStates)
  return {
    dashboard:  data.dashboard
    deviceStore: deviceStore
    viewStore: viewStore
  }