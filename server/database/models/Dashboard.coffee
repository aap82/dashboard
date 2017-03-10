DataType = require 'sequelize'
Model = require '../sequelize'

Dashboard = Model.define('Dashboard', {
  id:
                  type: DataType.INTEGER
                  autoIncrement: yes
                  primaryKey: yes
  title:          type: DataType.STRING
  deviceType:     type: DataType.STRING
  cols:           type: DataType.INTEGER
  rowHeight:      type: DataType.INTEGER
  marginX:        type: DataType.INTEGER
  marginY:        type: DataType.INTEGER
  style:          type: DataType.STRING
  devices:        type: DataType.STRING
  layouts:        type: DataType.STRING
  widgets:        type: DataType.STRING
  widgetEditor:   type: DataType.STRING
}, {
  timestamps: false
})









module.exports =
  Dashboard: Dashboard
