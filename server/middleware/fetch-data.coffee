async = require('asyncawait/async')
await = require('asyncawait/await')
getenv = require('getenv')
paths = require '../../config/paths'
SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
url = 'http://' + SERVER_HOST + ':' + SERVER_PORT + '/graphql'

gqlFetch = require('../../src/utils/fetch')(url)


fetchEditorData = async -> await gqlFetch('opName', 'getDashboardsAndDevices').then((results) -> JSON.stringify(results.data))


module.exports = ->
  async (ctx, next) ->
    console.log ctx.device
    state = switch
      when ctx.url is '/editor' then await fetchEditorData()
      else null
    ctx.state = state
    await next()







