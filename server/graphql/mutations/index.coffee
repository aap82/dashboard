dashboard = require('./dashboard')
{GraphQLObjectType} = require 'graphql'
mutation = {
  name: 'RootMutationType'
  fields:
    create: dashboard.createDashboardMutation
    update: dashboard.updateDashboardMutation
    delete: dashboard.deleteDashboardMutation
}


mutations = new GraphQLObjectType(mutation)

module.exports = mutations