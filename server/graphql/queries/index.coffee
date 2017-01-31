{GraphQLObjectType, GraphQLString} = require 'graphql'
dashboard = require('./dashboard')
{devices} = require('./devices').query


query =
  name: 'RootQueryType'
  fields:
    dashboard: dashboard.dashboardQuery
    dashboards: dashboard.dashboardsQuery
    devices: devices








queries = new GraphQLObjectType(query)

module.exports = queries


