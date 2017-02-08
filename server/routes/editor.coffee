pug = require 'pug'
paths = require '../../config/paths'
gqlFetch = require('../../src/utils/fetch')('http://192.168.1.10:9000/graphql')

module.exports = (path) ->
  view = path + '/editor'
  (req, res) =>
    gqlFetch('opName', 'getDashboardsAndDevices').then((results)=> results.data).then (data) =>
      initState = JSON.stringify(data)
      res.render view, {
        state: JSON.stringify(initState)
      }