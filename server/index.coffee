
express = require 'express'
app = express()


compression = require 'compression'

bodyParser = require 'body-parser'
jsonParser = bodyParser.json()
device = require('express-device')













app.use(require('./middleware/updates'))





app.listen(9000)