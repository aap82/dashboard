import {extendObservable, observable, computed, runInAction, action} from 'mobx'

import UserDevice from './Device'

export class AppStore
  constructor: ->
    @devices
    extendObservable @, {

    }

  init: (devices) ->
    @devices = (new UserDevice(device) for device in devices)


  handleColorPickerKeyDown: (e) =>
    console.log 'h'
    @closeSettingsColorPicker() if e.keyCode is 27






export appStore = new AppStore

export default appStore

