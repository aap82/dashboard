async = require('asyncawait/async')
await = require('asyncawait/await')

Router = require 'koa-router'
router = new Router()

router.get '/editor', async (ctx) ->
  state = await ctx.fetch('opName', 'getDashboardsAndDevices').then((results) ->results.data)
  ctx.render 'editor', {
    state: JSON.stringify JSON.stringify state
  }

module.exports = router



