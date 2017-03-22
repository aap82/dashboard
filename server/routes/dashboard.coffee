async = require('asyncawait/async')
await = require('asyncawait/await')
renderDashboard = require '../middleware/render-dashboard'
Router = require 'koa-router'
router = new Router()

router.get '/dashboard', async (ctx, next) ->
  results = await ctx.fetch('opName', 'defaultDashboard', {ip: ctx.device.ip}).then((results)-> results.data.userDevice)
  if results?.dashboard?
    ctx.state.store =
      dashboard: results.dashboard
    next()
  else
    ctx.redirect('/register')



router.use(renderDashboard())

router.get '/dashboard', async (ctx) ->
  ctx.render 'dashboard', {
      html: ctx.state.html
      state: JSON.stringify JSON.stringify ctx.state.store
  }


module.exports = router