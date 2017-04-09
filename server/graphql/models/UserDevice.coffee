async = require('asyncawait/async')
await = require('asyncawait/await')

{GraphQLObjectType, GraphQLString, GraphQLList} = require 'graphql'
mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default
{DashboardSchema, Dashboard, DashboardTC} = require './Dashboard'
{GeneralSettingsSchema, GridSettingsSchema,WidgetColorSchema,WidgetFontStylesSchema } = require './DashboardSettings'

UserDeviceSchema = new Schema({
  id: String
  ip: String
  name: String
  type: String
  registered:
    type: Boolean
    default: no
  location:
    type: String
  height: Number
  width: Number
  defaultDashboardId:
    type: String
  defaults:
    general: GeneralSettingsSchema
    grid: GridSettingsSchema
    widgetColor: WidgetColorSchema
    widgetFont: WidgetFontStylesSchema
})



UserDeviceSchema.index({ip: 1}, {unique: yes})
UserDevice = mongoose.model 'UserDevice', UserDeviceSchema
UserDeviceTC = composeWithMongoose(UserDevice)


UserDeviceTC.addFields({
  dashboardIDs:
    type: '[String]'
    resolve: async (source) ->
      await Dashboard.find({userDevice: source.ip}).lean().distinct('uuid')
    projection:
      ip: yes


})

UserDeviceTC.addRelation(
  'dashboard',
  => {
    resolver: DashboardTC.getResolver('findOne')
    args:
      filter: ((source) => {userDevice: source.ip, uuid: source.defaultDashboardId})
      skip: null
      sort: null
    projection:
      ip: yes
      uuid: yes
  }
)

UserDeviceTC.addRelation(
  'dashboards',
  => {
    resolver: DashboardTC.getResolver('findMany')
    args:
      filter: ((source) => {userDevice: source.ip})
      skip: null
      sort: null
    projection:
      ip: yes
  }
)



UserDeviceFields = "
  ip
  name
  type
  registered
  location
  height
  width
  defaultDashboardId
" 
  

module.exports =
  UserDevice: UserDevice
  UserDeviceTC: UserDeviceTC
  UserDeviceFields: UserDeviceFields

