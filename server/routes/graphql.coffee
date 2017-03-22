getenv = require('getenv')
{graphQLoptions} = require '../graphql'
{ graphqlKoa, graphiqlKoa  } = require 'graphql-server-koa'


Router = require 'koa-router'
router = new Router()

router.post('/graphql', graphqlKoa(graphQLoptions))
if getenv('NODE_ENV') is 'development'
  router.get('/graphiql', graphiqlKoa({ endpointURL: '/graphql'}))


module.exports = router