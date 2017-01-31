{Dashboard} = require '../database/models'
{GraphQLInt} = require 'graphql'
{dashboardType, dashboardInputType} = require '../types/dashboard'

exports = module.exports
exports.createDashboardMutation =
  type: dashboardType
  args:
    newDashboard: type: dashboardInputType
  resolve: (root, args) ->
    Dashboard.create(args.newDashboard).then (dashboard) ->
      return dashboard.get({plain: true})

exports.updateDashboardMutation =
  type: dashboardType
  args:
    id: type: GraphQLInt
    update: type: dashboardInputType
  resolve: (root, args) ->
    Dashboard.findById(args.id).then (dashboard) =>
      dashboard[key]= value for key, value of args.update
      dashboard.save()
      return dashboard.get({plain: true})



exports.deleteDashboardMutation =
  type: dashboardType
  args:
    id: type: GraphQLInt
  resolve: (root, args) ->
    Dashboard.findById(args.id).then (dashboard) =>
      dashboard.destroy({force: true})
      return {id: args.id}

module.exports =
  mutation:
    create: createDashboardMutation
    update: updateDashboardMutation
    delete: deleteDashboardMutation
