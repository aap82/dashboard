express = require('express')
pug = require 'pug'
app = express()
{graphiqlExpress } = require 'graphql-server-express'


if process.env.NODE_ENV is 'development'
  app.use '/graphiql', graphiqlExpress( endpointURL: '/graphql' )




app.get '/editor', require('./editor')

module.exports = app