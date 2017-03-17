async = require('asyncawait/async')
await = require('asyncawait/await')

Router = require 'koa-router'
router = new Router()

router.get '/dashboard', async (ctx) ->
  {dashboard, dashboards} = ctx.state
  deviceStates = await ctx.fetch('opName', 'GetDashboardDeviceStates', {devices: dashboard.devices}).then((result) -> return result.data.dashboardDeviceStates)
  ctx.render 'dashboard', {
    state: JSON.stringify JSON.stringify {dashboard: dashboard, dashboards, dashboards, deviceStates: deviceStates}
  }





module.exports = router