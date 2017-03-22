require('dotenv').config()
getenv = require('getenv')
SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'
gqlFetch = require('../src/utils/fetch')(GRAPHQL_ENDPOINT)

path = require('path')
paths = require('../config/paths')
graphql = require './routes/graphql'
koa = require('koa')
koaRouter = require('koa-router')
koaBody = require 'koa-bodyparser'
Pug = require('koa-pug')
sse_updates = require './routes/sse_updates'
{
  baseErrorHandling
  compressResponse
  serveStaticFiles
} = require './middleware/basic'

app = new koa()
app.context.fetch = gqlFetch


app.use(sse_updates.routes())


pug = new Pug({
  viewPath: path.join paths.views, getenv('NODE_ENV')
})

pug.use app
app.use koaBody()

app.use baseErrorHandling()
app.use(graphql.routes(), graphql.allowedMethods())
if getenv('NODE_ENV') is 'production'
  app.use compressResponse()
  app.use serveStaticFiles()





routes = require('./routes')
app.use(routes.routes(), routes.allowedMethods())
app.listen(SERVER_PORT)

require('./platforms')
console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT

