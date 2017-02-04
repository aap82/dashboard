{GraphQLObjectType} = require 'graphql'
dashboard = require('./dashboard')
{devicesSetupQuery, getFullStateQuery, getAllPlatformsQuery} = require('./devices')


query =
  name: 'RootQueryType'
  fields:
    dashboard: dashboard.dashboardQuery
    dashboards: dashboard.dashboardsQuery
    devicesSetup: devicesSetupQuery
    deviceStates: getFullStateQuery
    devicePlatforms: getAllPlatformsQuery





queries = new GraphQLObjectType(query)

module.exports = queries


