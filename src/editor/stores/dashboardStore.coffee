{extendObservable, action, computed, toJS, extendShallowObservable} = require 'mobx'
DashboardStore = require '../../stores/DashboardStore'

class DashboardStoreEditor extends DashboardStore

  constructor: ->
    @activeRecord = -1
    super()
    extendShallowObservable @, dashboards: []
    extendObservable @, {

      getUserDashboards: computed(->
        @dashboards.map((dashboard) -> id: dashboard.id, title: dashboard.title, deviceType: dashboard.deviceType)
      )
    }

  load: (d) ->
    console.log 'child'

  update: (id, dashboard) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards[idx] = dashboard
    return

  delete: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards.splice(idx)
    return

dashboardStore = new DashboardStoreEditor()
module.exports = dashboardStore