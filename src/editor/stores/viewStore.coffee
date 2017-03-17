{extendObservable, action, toJS} = require 'mobx'
t = require '../LeftPanel/buttons/types'
{extendObservable, action, runInAction} = require 'mobx'



class ViewState
  constructor: ({@modal, @editor, @store, @fetch, @dashboards}) ->
    @editor.fetch = @fetch
    @editor.dashboards = @dashboards
    extendObservable @, {
      selectedUserDevice: ''
      setUserDevice: action((id) ->
        @selectedUserDevice = id
      )

      loadUserDevice: action(->
        device = toJS(@editor.userDevices.get(@selectedUserDevice))
        console.log device
        if device.defaultDashboardId is null
          @editor.create('New Dashboard', device)
          @showEditorPage()
        else
          idx = @dashboards.findIndex((d) => d.uuid is device.defaultDashboardId)
          dashboard = @dashboards[idx]
          console.log dashboard
          @editor.load dashboard
          @showEditorPage()

        return


      )

      selectedDashboardId: 0
      setSelectedDashboard: action((id, dashboard) ->
        @selectedDashboardId = id
      )
      visiblePage: 'setup'
      setViewPageTo: action((view) -> if view in ['setup', 'editor'] then @visiblePage = view else return)

      showEditorPage: action(-> @visiblePage = 'editor')
      showSetupPage: action(-> @visiblePage = 'setup')

      loadDashboard: action(->
        idx = @dashboards.findIndex((d) => d.uuid is @selectedDashboardId)
        dashboard = @dashboards[idx]
        @editor.load dashboard
        @showEditorPage()
      )

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
    @editor.exit = => @showSetupPage()
    @editor.deleteDashboard = => @deleteDashboard()
    @editor.updateDashboard = (dashboard) => @updateDashboard(dashboard)



module.exports = ViewState



