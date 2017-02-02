require('dotenv').config()
getenv = require('getenv')

paths = require('../config/paths')
{connect} = require './database/models'
express = require 'express'
{ graphqlExpress } = require 'graphql-server-express'
{OperationStore} = require 'graphql-server-module-operation-store'
app = express()

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'


app.set 'view engine', 'pug'



app.use('/assets', express.static(paths.prodBuild))



compression = require 'compression'

bodyParser = require 'body-parser'
jsonParser = bodyParser.json()
device = require('express-device')
app.use(jsonParser);
app.use(bodyParser.urlencoded({extended: true}));
app.use(device.capture({parseUserAgent: true}));



app.use '/updates', require('./middleware/updates')
app.use '/commands', require('./middleware/commands')
app.get('*', require('./middleware/deviceTypeHandler'))










start = ->
  connect().then ->
    graphQLoptions = require('./graphql').getGraphQLOptions(OperationStore)
    app.use('/graphql', jsonParser, graphqlExpress(graphQLoptions))
    app.use(require('./routes'))
    app.listen(SERVER_PORT)
    console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT


start()