{Dashboard} = require '../database/models'
{defaultArgs, resolver, defaultListArgs} = require 'graphql-sequelize'
{GraphQLList} = require 'graphql'
{dashboardType} = require '../types/dashboard'

exports = module.exports

exports.dashboardQuery =
  type: dashboardType
  args: defaultArgs(Dashboard)
  resolve: resolver(Dashboard)



exports.dashboardsQuery =
  type: new GraphQLList(dashboardType)
  args: defaultListArgs(Dashboard)
  resolve: resolver(Dashboard)


