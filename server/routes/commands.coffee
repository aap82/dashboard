Router = require 'koa-router'
commands = new Router({
  prefix: '/commands'
})

{pimatic} = require('../platforms/pimatic/commands')

commands.get '/:platform/:device/:command', (ctx) ->
  {platform, device, command} = ctx.params
  ctx.status = 200
  switch platform
    when 'pimatic' then pimatic(device, command)
    else
      return



module.exports = commands
