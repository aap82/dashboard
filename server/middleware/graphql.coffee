express = require('express')
app = express()
{ graphqlExpress, graphiqlExpress } = require 'graphql-server-express'
{OperationStore} = require 'graphql-server-module-operation-store'

graphQLoptions = require('./graphql').getGraphQLOptions(OperationStore)

app.use('/graphql', jsonParser, graphqlExpress(graphQLoptions))

app.use('/graphiql', graphiqlExpress({
  endpointURL: '/graphql',
}))