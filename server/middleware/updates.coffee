express = require('express')
app = express()
sse = require './utils/sse'

app.get '/updates', (req, res) ->
  console.log 'hi'
  sse.add(req, res)


module.exports = app