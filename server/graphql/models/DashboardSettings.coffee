mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default
DashboardSettingSchema = new Schema({
  uuid: String
  deviceIP: String

  gridBackgroundColor: String
  gridOrientation: String
  gridColumns: Number
  gridColUnit: String
  gridCols: Number
  griRowHeight: Number
  gridMarginX: Number
  gridMarginY: Number
  gridWidth: Number
  gridHeight: Number
  gridMaxRows:Number
  widgetBackgroundColor: String
  widgetPrimaryColor: String
  widgetPrimaryFontSize: Number
  widgetPrimaryFontWeight: Number
  widgetSecondaryColor: String
  widgetSecondaryFontSize: Number
  widgetSecondaryFontWeight: Number
})
DashboardSettingSchema.index({uuid: 1}, {unique: yes})
DashboardSetting = mongoose.model 'DashboardSetting', DashboardSettingSchema
DashboardSettingTC = composeWithMongoose(DashboardSetting)

module.exports =
  DashboardSettingSchema: DashboardSettingSchema
  DashboardSetting: DashboardSetting
  DashboardSettingTC: DashboardSettingTC

