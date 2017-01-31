{GraphQLSchema} = require 'graphql'



clientQueries = require './client/queries'
clientMutations = require './client/mutations'

queries = require './queries'
mutations = require './mutations'

schema = new GraphQLSchema(
  query: queries
  mutation: mutations
)

exports.getGraphQLOptions = (OperationStore) =>
  store = new OperationStore(schema)
  store.put opName for key, opName of clientQueries
  store.put opName for key, opName of clientMutations

  return {
    schema: schema
    formatParams: (params) =>
      if params.operationName?
        params['query'] = store.get(params.operationName)

      return params
  }