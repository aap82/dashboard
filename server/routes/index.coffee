Router = require 'koa-router'
getenv = require('getenv')
paths = require('../../config/paths')
router = new Router()
commands = require './commands'
device_handler = require('../middleware/device-router')






router.use commands.routes(), commands.allowedMethods()
















require('./graphiql')(router) if getenv('NODE_ENV') is 'development'



router.get('*', device_handler())
router.get '/editor', require('./editor')



module.exports = router