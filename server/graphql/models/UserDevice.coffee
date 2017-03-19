mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default
{DashboardTC} = require './Dashboard'


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
})



UserDeviceSchema.index({ip: 1}, {unique: yes})
UserDevice = mongoose.model 'UserDevice', UserDeviceSchema
UserDeviceTC = composeWithMongoose(UserDevice)

UserDeviceTC.addRelation(
  'dashboard',
  => {
    resolver: DashboardTC.getResolver('findOne')
    args:
      filter: ((source) => uuid: source.defaultDashboardId)
      skip: null
      sort: null
    projection:
      defaultDashboardId: yes
  }



)
UserDeviceTC.addRelation(
  'dashboards',
  => {
    resolver: DashboardTC.getResolver('findMany')
    args:
      filter: ((source) => deviceType: source.type)
      skip: null
      sort: null
    projection:
      type: yes
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

