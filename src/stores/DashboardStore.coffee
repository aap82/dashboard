
class DashboardStore
  constructor: ->
    @dashboards = []
    @fetch = null

  init: (dashboards, fetch) ->
    @dashboards = dashboards
    @fetch = fetch
    return

  getDashboardById: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards[idx]


  load: (d) ->
    console.log 'main'

  getDashboards: ->
    @dashboards

  add: (dashboard) ->
    @activeRecord = dashboard.id
    console.log dashboard, @dashboards
    @dashboards.push dashboard
    return






module.exports = DashboardStore

