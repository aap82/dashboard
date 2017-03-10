async = require('asyncawait/async')
await = require('asyncawait/await')

module.exports = ->
  async (ctx, next) ->
    type = ctx.deviceType
    url = ctx.url
    if url in ['/editor', '/graphiql'] and type is 'desktop' or
    url is '/dashboard' and type in ['tablet', 'phone']
      await next()
    else if type is 'desktop'
      ctx.redirect '/editor'
    else if type in ['tablet', 'phone']
      ctx.redirect '/dashboard'
    else
      ctx.status(404)


