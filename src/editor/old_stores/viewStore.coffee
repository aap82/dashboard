import {extendObservable, action, toJS} from 'mobx'
import t from '../LeftPanel/buttons/types'






class ViewState
  constructor: () ->
    extendObservable @, {
      visiblePage: 'setup'
      setViewPageTo: action((view) -> if view in ['setup', 'editor'] then @visiblePage = view else return)

      showEditorPage: action(-> @visiblePage = 'editor')
      showSetupPage: action(-> @visiblePage = 'setup')

      updateDashboard: action((dashboard) =>
        idx = @dashboards.findIndex((d) => d.uuid is @selectedDashboardId)
        if idx < 0
          @dashboards.push dashboard
        else
          @dashboards[idx] = dashboard
      )



      deleteDashboard: action((uuid)->
        runInAction(=>
          idx = @dashboards.findIndex((d) => d.uuid is uuid)
          @dashboards.splice(idx, 1)
          @selectedDashboardId = 0
          @showSetupPage()
        )
      )

    }


viewState = new ViewState
export default viewState



