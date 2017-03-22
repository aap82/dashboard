async = require('asyncawait/async')
await = require('asyncawait/await')
getenv = require('getenv')
GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'






module.exports = ->
  async (ctx, next) ->
    {ip, type} = ctx.device
    {url} = ctx
    if url is '/editor'and type is 'desktop' or
    (type in ['tablet', 'phone'] and url is '/updates') or
    url in ['/graphql', '/favicon.ico']
      next()
    else if type is 'desktop'
      ctx.redirect '/editor'
    else if type in ['tablet', 'phone']
      if url is '/register'
        next()
      else if url is '/dashboard'
        next()
      else
        ctx.redirect('/dashboard')
    else
      ctx.status = 404


