require('dotenv').config()
getenv = require('getenv')
express = require 'express'
paths = require('../config/paths')
compression = require 'compression'
device = require('express-device')
bodyParser = require 'body-parser'
{ graphqlExpress } = require 'graphql-server-express'
{OperationStore} = require 'graphql-server-module-operation-store'

{connect} = require './database/models'
app = express()
jsonParser = bodyParser.json()

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'


app.set 'view engine', 'pug'
app.use(require('./routes'))


if getenv('NODE_ENV') is 'production'
  app.use('/assets', express.static(paths.prodBuild))



app.use(jsonParser);
app.use(bodyParser.urlencoded({extended: true}));
app.use(device.capture({parseUserAgent: true}));

app.use '/updates', require('./middleware/updates')
app.use '/commands', require('./middleware/commands')
app.use(require('./middleware/deviceTypeHandler'))


app.get('/chicken', (req, res, next) -> next())


start = ->
  connect().then ->
    graphQLoptions = require('./graphql').getGraphQLOptions(OperationStore)
    app.use('/graphql', jsonParser, graphqlExpress(graphQLoptions))

    app.listen(SERVER_PORT)
    console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT


start()