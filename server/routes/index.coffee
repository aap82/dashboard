getenv = require('getenv')
path = require 'path'
express = require('express')
pug = require 'pug'
app = express()
paths = require('../../config/paths')

viewPath = path.join paths.views, getenv('NODE_ENV')


app.get '/editor', require('./editor')(viewPath)

module.exports = app