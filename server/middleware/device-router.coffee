module.exports = ->
  (ctx, next) ->
    url = ctx.url
    type = ctx.device.type
    if url in ['/editor', '/graphiql'] and type is 'desktop' or
    url is '/dashboard' and type in ['tablet', 'phone']
      return next()
    else if type is 'desktop'
      ctx.redirect '/editor'
    else if type in ['tablet', 'phone']
      ctx.redirect '/dashboard'
    else
      ctx.status(404)


