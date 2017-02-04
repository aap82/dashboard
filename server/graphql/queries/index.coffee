{GraphQLObjectType} = require 'graphql'
dashboard = require('./dashboard')
{devicesSetupQuery, getFullStateQuery} = require('./devices')


query =
  name: 'RootQueryType'
  fields:
    dashboard: dashboard.dashboardQuery
    dashboards: dashboard.dashboardsQuery
    devicesSetup: devicesSetupQuery
    deviceStates: getFullStateQuery






queries = new GraphQLObjectType(query)

module.exports = queries


