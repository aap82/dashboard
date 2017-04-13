getenv = require('getenv')
graphQLoptions = require '../graphql'
{ graphqlKoa, graphiqlKoa  } = require 'graphql-server-koa'


Router = require 'koa-router'
graphql = new Router()
graphql.post('/graphql', graphqlKoa(graphQLoptions))

if getenv('NODE_ENV') is 'development'
  graphql.get('/graphiql', graphiqlKoa({ endpointURL: '/graphql'}))


module.exports = graphql