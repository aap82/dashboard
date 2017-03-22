async = require('asyncawait/async')
await = require('asyncawait/await')

Router = require 'koa-router'
router = new Router()

router.get '/register', async (ctx) ->
  {device} = ctx
  state = {}
  state = await ctx.fetch('opName', 'GetUserDevice', {ip: device.ip}).then((result) -> return result.data.userDevice)
  if state is null
    state = await ctx.fetch('opName', 'AddUserDevice', {device: device}).then((result) -> return result.data.addUserDevice.record)
  ctx.render 'register', {
    state: JSON.stringify JSON.stringify state
  }

module.exports = router



