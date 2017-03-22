DashboardModel = (title='New Dashboard', deviceType='tablet') ->
  title:  title
  deviceType:  deviceType
  cols:  if deviceType is 'phone' then 80 else 155
  marginX:  0
  marginY:  0
  rowHeight: 5
  widgets:  []
  layouts:  []
  devices:  []
  style:
    position: 'relative'
    height: '100%'
    width:  if deviceType is 'phone' then 500 else 1200
    backgroundColor: '#be682e'
    color: 'white'






class Dashboard
  constructor: ->




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






export default DashboardStore

