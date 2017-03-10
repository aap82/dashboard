{deserialize, update} = require 'serializr'
{extendObservable, toJS} = require 'mobx'
uuidV4 = require('uuid/v4')


createDashboardObj = (id, title='New Dashboard', deviceType='tablet', defaults=null) ->
  width = if deviceType is 'phone' then 500 else 1200
  return {
    uuid: uuidV4()
    id: id
    title:  title
    deviceType:  deviceType
    cols:  if deviceType is 'phone' then 80 else 155
    marginX:  0
    marginY:  0
    rowHeight: 5
    widgets:  []
    layouts:  []
    devices:  []
    width:  width
    style:
      position: 'relative'
      height: '100%'
      width:  width
      backgroundColor: defaults?.backgroundColor ? '#be682e'
      color: defaults?.color ? 'white'
  }

class DashboardStore
  constructor: ->
    @dashboards = []
    @createId = 500
    @activeRecord = -1

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


  getDashboardById: (id) ->
    idx = @dashboards.findIndex( (d) => d.id is id)
    @dashboards[idx]





dashboardStore = new DashboardStore

module.exports = dashboardStore

