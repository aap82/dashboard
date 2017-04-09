mongoose = require('mongoose')
Schema = mongoose.Schema





GeneralSettingsSchema = new Schema({
  backgroundColor:
    color: String
    alpha: Number
})



GridSettingsSchema = new Schema({
  orientation: String
  cols: Number
  rowHeight: Number
  marginX: Number
  marginY: Number
  width: Number
  height: Number
  maxRows: Number
})

WidgetColorSchema = new Schema({
  backgroundColor:
    color: String
    alpha: Number
})



WidgetFontStylesSchema = new Schema({
  primaryColor: String
  primaryFontSize: Number
  primaryFontWeight: Number
  secondaryColor: String
  secondaryFontSize: Number
  secondaryFontWeight: Number
})


DashboardSettingsSchema = new Schema({
  uuid: String
  general: GeneralSettingsSchema
  grid: GridSettingsSchema
  widgetColor: WidgetColorSchema
  widgetFont: WidgetFontStylesSchema

})


module.exports =
  GeneralSettingsSchema: GeneralSettingsSchema
  GridSettingsSchema: GridSettingsSchema
  WidgetColorSchema: WidgetColorSchema
  WidgetFontStylesSchema: WidgetFontStylesSchema
  DashboardSettingsSchema: DashboardSettingsSchema
