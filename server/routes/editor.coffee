paths = require('../../config/paths')
express = require('express')
pug = require 'pug'
app = express()

gqlFetch = require('../../src/utils/fetch')('http://192.168.1.10:9000/graphql')



app.get '/', (req, res) ->
  gqlFetch('opName', 'getDashboardsAndDevices').then((results)=> results.data).then (data) =>
    initState = JSON.stringify(data)
    res.send(pug.renderFile('./server/views/editor.pug', {
      state: JSON.stringify(initState)
    }))


module.exports = app