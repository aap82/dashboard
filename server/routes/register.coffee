async = require('asyncawait/async')
await = require('asyncawait/await')

Router = require 'koa-router'
router = new Router()

router.get '/register', async (ctx) ->
  {device} = ctx
  state = {}
  if device.ip in ctx.devices
    state = await ctx.fetch('opName', 'GetUserDevice', {ip: device.ip}).then((result) -> return result.data.userDevice)
  else

    state = await ctx.fetch('opName', 'AddUserDevice', {device: device}).then((result) -> return result.data.addUserDevice.record)
    ctx.devices.push(device.ip)



  ctx.render 'register', {
    state: JSON.stringify JSON.stringify state
  }

module.exports = router



