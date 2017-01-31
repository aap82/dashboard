require('dotenv').config()
{connect} = require './database/models'
express = require 'express'
{ graphqlExpress, graphiqlExpress } = require 'graphql-server-express'
{OperationStore} = require 'graphql-server-module-operation-store'
app = express()


compression = require 'compression'

bodyParser = require 'body-parser'
jsonParser = bodyParser.json()
device = require('express-device')












app.use '/commands', require('./middleware/commands')
app.use '/updates', require('./middleware/updates')








start = ->
  connect().then ->
    graphQLoptions = require('./graphql').getGraphQLOptions(OperationStore)
    app.use('/graphql', jsonParser, graphqlExpress(graphQLoptions))
    app.use('/graphiql', graphiqlExpress({
      endpointURL: '/graphql',
    }))
    app.listen(9000)


start()