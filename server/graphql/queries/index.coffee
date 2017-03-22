{GraphQLList, GraphQLString, GraphQLBoolean} = require 'graphql'
{DashboardTC, UserDeviceTC} = require '../models'
{devicesSetupQuery, getFullStateQuery, getAllPlatformsQuery, getDashboardDeviceStatesQuery} = require('./devices')
MTAScheduleQuery = require './mta'

#
module.exports =
  dashboard: DashboardTC.getResolver('findOne')
  dashboards: DashboardTC.getResolver('findMany')
  userDevice: UserDeviceTC.getResolver('findOne')
  userDevices: UserDeviceTC.getResolver('findMany')
  userDashboard: UserDeviceTC.getResolver('findOne')
  devicesSetup: devicesSetupQuery
  deviceStates: getFullStateQuery
  devicePlatforms: getAllPlatformsQuery
  dashboardDeviceStates: getDashboardDeviceStatesQuery
  mta: MTAScheduleQuery





