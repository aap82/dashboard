import editor from './stores/editorStore'
import viewState from './stores/viewStore'
import {update, getDefaultModelSchema, setDefaultModelSchema, deserialize, serialize} from  'serializr'
import widgets from './stores/widgetsStore'
import DeviceStore from '../stores/DeviceStore'
import {widgetStore} from './models/Widget'
import {dashboardSchema} from './models/Dashboard'
import {dashboardStore} from './stores/Dashboard'
import Time from '../stores/Time'
import modalStore from './stores/modalsStore'
import forms from './forms'
import userDevices from './stores/UserDevices'
import appStore from './stores/AppStore'

gqlFetch = require('../utils/fetch')('/graphql')

export configureStores = (data) ->
  appStore.init(data.userDevices, data.dashboards)
  editor.loadUserDevices(data.userDevices)
  editor.fetch = gqlFetch
  editor.exit = -> viewState.showSetupPage()
  userDevices.load(data.userDevices)
  console.log appStore.devices.values()
  deserialize(dashboardSchema, d) for d in data.dashboards
  dashboardStore.load(data.dashboards)
  deviceStates = if data.deviceStates.states? then JSON.parse(data.deviceStates.states) else []
  DeviceStore.states.replace(deviceStates)
  DeviceStore.addDevice(device) for device in data.devicesSetup
  widgets.devices = DeviceStore.devices
  widgets.platforms = JSON.parse(data.devicePlatforms.platforms)
  return {
    viewState: viewState
    editor: editor
    widgets: widgets
    widgetStore: widgetStore
    modal: modalStore
    deviceStore: DeviceStore
    weather: data.weather
    time: Time
    forms: forms
    dashboards: dashboardStore.dashboards
    userDevices: userDevices


  }

