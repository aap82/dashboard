require 'isomorphic-fetch'
defaults = require('101/defaults')


module.exports = (graphqlUrl) =>
  (type, input, vars, opts) ->
    if type not in ['query','opName'] then return
    vars = vars or {}
    body =
      variables: vars
    if type is 'query'
      body.query = input
    if type is 'opName'
      body.operationName = input
    opts = opts or {}
    opts.body = JSON.stringify body
    # default opts
    defaults opts,
      method: 'POST'
      headers: new Headers
    # default headers
    headers = opts.headers
    if !headers.get('content-type')
      opts.headers.append 'content-type', 'application/json'
    fetch(graphqlUrl, opts).then (res) ->
#      console.log res
      res.json()

