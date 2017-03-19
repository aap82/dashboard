getenv = require('getenv')
path = require 'path'
express = require('express')
pug = require 'pug'
app = express()
paths = require('../../config/paths')
{ graphiqlExpress } = require 'graphql-server-express'

viewPath = path.join paths.views, getenv('NODE_ENV')

if getenv('NODE_ENV') is 'development'
  app.use '/graphiql', graphiqlExpress({endpointURL: '/graphql'})

app.use '/dashboard', require('./dashboard')
app.get '/editor', require('./editor')(viewPath)


module.exports = app