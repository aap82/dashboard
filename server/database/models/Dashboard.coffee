DataType = require 'sequelize'
Model = require '../sequelize'

Dashboard = Model.define('Dashboard', {
  id:
    type: DataType.INTEGER
    autoIncrement: yes
    primaryKey: yes
  title:
    type: DataType.STRING
    allowNull: no
    unique: no
  deviceType:
    type: DataType.STRING
    allowNull: no
    unique: no
  cols:
    type: DataType.INTEGER
  marginX:
    type: DataType.INTEGER
  marginY:
    type: DataType.INTEGER
  rowHeight:
    type: DataType.INTEGER
  dashboardStyle:
    type: DataType.STRING
  widgetBackgroundAlpha:
    type: DataType.INTEGER
  widgetCardDepth:
    type: DataType.INTEGER
  widgetBackgroundColor:
    type: DataType.STRING
  widgetStyle:
    type: DataType.STRING
  layouts:
    type: DataType.STRING
  widgets:
    type: DataType.STRING
  devices:
    type: DataType.STRING

}, {
  timestamps: false
})



module.exports =
  Dashboard: Dashboard
