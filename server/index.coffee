require('dotenv').config()
async = require('asyncawait/async')
await = require('asyncawait/await')
getenv = require('getenv')

GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'
gqlFetch = require('../src/utils/fetch')(GRAPHQL_ENDPOINT)
SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'


path = require('path')
paths = require('../config/paths')
db = require './graphql'
koa = require('koa')
koaRouter = require('koa-router')
koaBody = require 'koa-bodyparser'
Pug = require('koa-pug')
{ graphqlKoa } = require('graphql-server-koa')
sse_updates = require './routes/sse_updates'
app = new koa()


app.context.fetch = gqlFetch

router = new koaRouter()


pug = new Pug({
  viewPath: path.join paths.views, getenv('NODE_ENV')
})


app.use  async (ctx, next) =>
  try
    await next()
  catch err
    console.error(err)
    ctx.body = { message: err.message }
    ctx.status = err.status || 500

app.use(sse_updates.routes())
pug.use(app)
app.use(koaBody())


db.init async (devices, graphQLoptions) =>
  app.context.devices = devices
  router.post('/graphql', graphqlKoa(graphQLoptions))
  app.use(router.routes())
  app.use(router.allowedMethods())
  app.use(require('./routes').routes())
  app.use(require('./routes').allowedMethods())


  app.listen(SERVER_PORT)
  userDevices = await gqlFetch('opName', 'AllDeviceIPs').then((result) -> return result.data.userDevices)
  app.context.ips = (value for key, value of userDevices)

  require('./platforms')
  console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT

