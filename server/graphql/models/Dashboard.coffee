mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default
uniq = require('lodash.uniq')

LayoutSchema = new Schema({
  i: String
  w: Number
  h: Number
  x: Number
  y: Number
  minW: Number
  minH: Number
  static: Boolean
})

WidgetSchema = new Schema({
  uuid: String
  key: String
  label: String
  overrideStyle: Boolean
  type: String
  cardDepth: Number
  style:
    backgroundColor: String
    borderRadius: Number
    color: String
  device:
    id: String
    deviceId: String
    platform: String

})

DashboardSchema = new Schema({
  uuid:
    type: String
    index: yes
  title: String
  userDevice: String
  deviceType: String
  cols: Number
  marginX: Number
  marginY: Number
  rowHeight: Number
  height: Number
  width: Number
  layouts: [LayoutSchema]
  widgets: [WidgetSchema]
  backgroundColor: String
  widgetBorderRadius: Number
  widgetCardDepth: Number
  widgetBackgroundColor: String
  widgetBackgroundAlpha:
    type: Number
    defaultValue: 100
  widgetFontColor: String
  widgetFontSizePrimary: Number
  widgetFontSizeSecondary: Number
  widgetFontWeightPrimary: String
  widgetFontWeightSecondary: String
})

DashboardSchema.index({uuid: 1}, {unique: yes})
Dashboard = mongoose.model 'Dashboard', DashboardSchema
DashboardTC = composeWithMongoose(Dashboard)



DashboardTC.addFields({
  devices:
    type: '[String]'
    description: 'Array of Devices'
    resolve: (source) =>
      if source.widgets?
        uniq(source.widgets.map((w) => w.device.id))
      else
        []
})


DashboardFields = "
  uuid
  title
  deviceType
  cols
  marginX
  marginY
  rowHeight
  height
  width
  userDevice
  backgroundColor
  widgetBorderRadius
  widgetCardDepth
  widgetBackgroundColor
  widgetBackgroundAlpha
  widgetFontColor
  widgetFontSizePrimary
  widgetFontSizeSecondary
  widgetFontWeightPrimary
  widgetFontWeightSecondary
  devices
  layouts {
    i
    w
    h
    x
    y
    minW
    minH
    static
  }
  widgets {
    uuid
    key
    label
    overrideStyle
    type
    cardDepth
    style {
      backgroundColor
      borderRadius
      color
    }
    device {
      id
      deviceId
      platform
    }
  }
"


DashboardEditorFields = "
  uuid
  title
  deviceType
  cols
  marginX
  marginY
  rowHeight
  height
  width
  userDevice
  backgroundColor
  widgetBorderRadius
  widgetCardDepth
  widgetBackgroundColor
  widgetBackgroundAlpha
  widgetFontColor
  devices
  layouts {
    i
    w
    h
    x
    y
    minW
    minH
    static
  }
  widgets {
    uuid
    key
    label
    overrideStyle
    type
    cardDepth
    style {
      backgroundColor
      borderRadius
      color
    }
    device {
      id
      deviceId
      platform
    }
  }
"





module.exports =
  Dashboard: Dashboard
  DashboardTC: DashboardTC
  fields:
    DashboardEditorFields: DashboardEditorFields
    DashboardFields: DashboardFields