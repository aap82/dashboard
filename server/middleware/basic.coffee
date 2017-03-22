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


exports.serveStaticFiles = ->
  staticFolder = mount '/public', serve(paths.root)
  distFolder = mount '/', serve(paths.prodBuild)
  return compose([staticFolder, distFolder])
