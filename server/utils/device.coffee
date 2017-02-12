device = require('./lib/device-parser')
module.exports = ->
  (ctx, next) ->
    source = ctx.headers['user-agent'] or 'unknown'
    mydevice = device(source)
    ctx.device =
      ip: if ctx.ip.split('f:')?[1]? then ctx.ip.split('f:')[1] else ''
      name: mydevice.model
      type: mydevice.type
    next()
