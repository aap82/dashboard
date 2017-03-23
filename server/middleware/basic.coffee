async = require('asyncawait/async')
await = require('asyncawait/await')
compose = require  'koa-compose'
mount = require  'koa-mount'
serve = require  'koa-static'
compress = require  'koa-compress'
paths = require '../../config/paths'

exports.baseErrorHandling = ->
  async (ctx, next) =>
    try
      await next()
    catch err
      console.error "BASE ERROR HANDLING: #{err.name} : #{err.message}"
      ctx.body = { name: err.name, message: err.message, stack: err.stack }
      ctx.status = err.status or 500



exports.compressResponse = ->
  return compress()


exports.serveStaticFiles = (env) ->
  static_files = [mount '/public', serve(paths.publicFiles)]
  static_files.push mount('/', serve(paths.prodBuild)) if env is 'production'
  return compose(static_files)

