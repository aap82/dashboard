getenv = require('getenv')
paths = require '../../config/paths'
SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
url = 'http://' + SERVER_HOST + ':' + SERVER_PORT + '/graphql'

gqlFetch = require('../../src/utils/fetch')(url)

module.exports = (ctx) ->
  gqlFetch('opName', 'getDashboardsAndDevices').then (results) ->
    results.data
  .then (data) ->
    initState = JSON.stringify(data)
    ctx.render 'editor', {
      state: JSON.stringify(initState)
    }