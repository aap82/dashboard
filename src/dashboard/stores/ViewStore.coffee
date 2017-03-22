import { extendObservable, observable, action, runInAction} from 'mobx'
import DeviceStore from './DeviceStore'
gqlFetch = require('../../utils/fetch')('/graphql')
class ViewStore
  constructor: (@deviceStore, @fetch) ->

    extendObservable @, {
      started: no
      visible: no

      init: action(->
        @deviceStore.subscribe()
        @visible = yes
        @started = yes
      )

    }


viewStore = new ViewStore(DeviceStore, gqlFetch)

export default  viewStore