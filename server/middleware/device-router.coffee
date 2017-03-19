async = require('asyncawait/async')
await = require('asyncawait/await')
getenv = require('getenv')
GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'
gqlFetch = require('../../src/utils/fetch')(GRAPHQL_ENDPOINT)





module.exports = ->
  async (ctx, next) ->
    {ip, type} = ctx.device
    {devices, url} = ctx
    if url is '/editor'and type is 'desktop' or
    type in ['tablet', 'phone'] and url is '/updates'
      next()
    else if type is 'desktop'
      ctx.redirect '/editor'
    else if type in ['tablet', 'phone']

      if ip not in  devices
        redirect('/register')
      else
        results = await gqlFetch('opName', 'GetUserDeviceAndDashboard', {ip: ctx.device.ip}).then((results)-> results.data.userDevice)
        if url is '/dashboard' and results.dashboard isnt null
          ctx.state = results
          next()
        else
          ctx.status = 404
    else
      ctx.status = 404


