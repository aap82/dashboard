async = require('asyncawait/async')
await = require('asyncawait/await')
getenv = require('getenv')

DeviceStore = require '../store'
{render_dashboard} = require '../middleware/render-dashboard'
Router = require 'koa-router'
dashboard = new Router({
  prefix: '/dashboard'
})

dashboard.get '/', async (ctx, next) ->
  results = await ctx.fetch('opName', 'defaultDashboard', {ip: ctx.device.ip}).then((results)-> results.data.userDevice)
  if results?.dashboard?
    ctx.state.manifestType = if results.dashboard.height > results.dashboard.width then 'portrait' else 'landscape'
    devices = results.dashboard.devices ?= []
    ctx.state.store =
      dashboard: results.dashboard
      deviceStates: await DeviceStore.getStatesObj(devices)
    next()
  else
    ctx.redirect('/register')


if getenv('NODE_ENV') is 'production'
  dashboard.get '/', render_dashboard()

dashboard.get '/', async (ctx) ->

  ctx.render 'dashboard', {
      html: ctx.state.html
      state: JSON.stringify JSON.stringify ctx.state.store
      manifestType: ctx.device.manifestType

  }


module.exports = dashboard