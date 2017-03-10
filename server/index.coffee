require('dotenv').config()
getenv = require('getenv')
path = require('path')
paths = require('../config/paths')

koa = require('koa')
koaRouter = require('koa-router')
koaBody = require 'koa-bodyparser'
Pug = require('koa-pug')
{ graphqlKoa } = require('graphql-server-koa')
{OperationStore} = require('graphql-server-module-operation-store')

{init_database } = require('./database/models')

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
device_grabber = require './middleware/device-grabber'
app = new koa()
router = new koaRouter()
pug = new Pug({
  viewPath: path.join paths.views, getenv('NODE_ENV')
})


pug.use(app)
app.use(koaBody())
app.use(device_grabber())


#
#app.use async((ctx, next) =>
#  console.log ctx.request.user
#  await type = require('util').inspect(ctx.userAgent)
#  console.log type
#)
#app.use ((ctx, next) =>
#
#  console.log ctx.device
#  next()
#)

start_server = ->
  graphQLoptions = require('./graphql').getGraphQLOptions(OperationStore)
  router.post('/graphql', graphqlKoa(graphQLoptions))
  app.use(require('./routes').routes())
  app.use(require('./routes').allowedMethods())
  app.use(router.routes())
  app.use(router.allowedMethods())

  app.listen(SERVER_PORT)
  require('./platforms')
  console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT
init_database().then start_server