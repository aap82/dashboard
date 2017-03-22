getenv = require('getenv')

MONGO_DB = getenv 'MONGO_DB'
models = require './models'
mongoose = require('mongoose')
promise = require('bluebird')
mongoose.Promise = promise
mongoose.connect MONGO_DB


{ GQC } = require 'graphql-compose'
{init_store} = require './store'




QueryFields = require './queries/index'
MutationFields = require './mutations/index'



GQC.rootQuery().addFields(QueryFields)
GQC.rootMutation().addFields(MutationFields)
schema = GQC.buildSchema()
store = init_store(schema)
graphQLoptions =
  schema: schema
  formatParams: (params) =>
    if params.operationName?
      params['query'] = store.get(params.operationName)
    return params



exports.graphQLoptions = graphQLoptions



exports.init = (cb) ->
  cb(graphQLoptions)


