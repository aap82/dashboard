Router = require 'koa-router'
getenv = require('getenv')
paths = require('../../config/paths')
router = new Router()
commands = require './commands'
device_router = require('../middleware/device-router')
fetch_data = require('../middleware/fetch-data')




router.use commands.routes(), commands.allowedMethods()

router.get('*', device_router())
router.get(['/editor', '/dashboard'], fetch_data())

require('./graphiql')(router) if getenv('NODE_ENV') is 'development'




router.get '/editor', (ctx) ->
  ctx.render 'editor', {
    state: JSON.stringify ctx.state
  }



module.exports = router