Router = require 'koa-router'

paths = require('../../config/paths')
router = new Router()
commands = require './commands'
device_grabber = require('../middleware/device-grabber')
device_router = require('../middleware/device-router')
dashboard = require('./dashboard')
editor = require './editor'
register = require './register'


router.use commands.routes(), commands.allowedMethods()
router.use(device_grabber())
router.use register.routes()
router.get('*', device_router())
router.use editor.routes()
router.use dashboard.routes(), dashboard.allowedMethods()

module.exports = router








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
