queries = require './queries'
mutations = require './mutations'
{OperationStore} = require('graphql-server-module-operation-store')

exports.init_store = (schema) =>
  store = new OperationStore(schema)
  store.put opName for key, opName of queries
  store.put opName for key, opName of mutations
  return store