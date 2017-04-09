import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Panel from './Panel'
import Dashboard from './Dashboard'
import App from './App'


class Editor
  constructor: (dashboard) ->
    @dashboard = dashboard
    extendObservable @, {
      device: computed(-> @dashboard.device)
      zoom: 1
      isAddingDashboard: no
      isEditing: no
      selectDashboard: action((dash) -> @dashboard.deserialize(@device, dash))
      createDashboard: action("Create Dashboard", (title) ->
        runInAction(=>
          @dashboard.initNew(title)
          @device.dashboards.push @dashboard.serialize()
          @isAddingDashboard = no
        )
      )





    }


editor = new Editor(Dashboard)

export default editor
