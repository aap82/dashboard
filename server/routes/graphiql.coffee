{ graphiqlKoa  } = require 'graphql-server-koa'

module.exports = (router) ->
  router.get('/graphiql', graphiqlKoa({ endpointURL: '/graphql'}))
  router