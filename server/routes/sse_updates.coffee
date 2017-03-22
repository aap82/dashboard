
async = require('asyncawait/async')
await = require('asyncawait/await')
{PassThrough} = require('stream')
SSE = require('../sse')


Router = require 'koa-router'
sse_updates = new Router({
  prefix: '/updates'
})


sse_updates.get ['/', '/:topics'], async (ctx) ->
  topics = if ctx.params.topics? then ctx.params.topics.split(',') else []
  stream = new PassThrough()
  ctx.socket.setTimeout 0x7FFFFFFF
  ctx.type = 'text/event-stream'
  ctx.set('Cache-Control', 'no-cache')
  ctx.set('Connection', 'keep-alive')

  id = await SSE.add(stream, topics)

  ctx.req.on 'close', (->
    SSE.remove(id)
    ctx.res.end())
  ctx.req.on 'finish', (->
    SSE.remove(id)
    ctx.res.end())
  ctx.req.on 'error', (->
    SSE.remove(id)
    ctx.res.end())
  ctx.body = stream




module.exports = sse_updates









