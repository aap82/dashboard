pug = require 'pug'
gqlFetch = require('../../../src/utils/fetch')('http://192.168.1.10:9000/graphql')
module.exports = (req, res) =>
  gqlFetch('opName', 'getDashboardsAndDevices').then((results)=> results.data).then (data) =>
    initState = JSON.stringify(data)
    res.send(pug.renderFile('./server/views/editor.pug', {
      state: JSON.stringify(initState)
    }))