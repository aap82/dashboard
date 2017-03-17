async = require('asyncawait/async')
await = require('asyncawait/await')
Router = require 'koa-router'
getenv = require('getenv')
paths = require('../../config/paths')
router = new Router()
commands = require './commands'
device_grabber = require('../middleware/device-grabber')
device_router = require('../middleware/device-router')
dashboard = require('./dashboard')
editor = require './editor'
register = require './register'

env = getenv('NODE_ENV')







router.use commands.routes(), commands.allowedMethods()
require('./graphiql')(router) if env is 'development'

router.use(device_grabber())
router.use register.routes()



router.get('*', device_router())


router.use editor.routes()
router.use dashboard.routes(), dashboard.allowedMethods()

module.exports = router


initialize_routes = (app) ->





#
#deviceStates = await gqlFetch('opName', 'GetDashboardDeviceStates', {devices: devices}).then((result) -> return result.data.dashboardDeviceStates)
#
#
#
#  ctx.render 'dashboard', {
#    state: JSON.stringify JSON.stringify({
#      state:
  #      dashboard: state.dashboard
  #      dashboards: state.dashboards
  #      devicesStates: deviceStates#
#    })
#  }
