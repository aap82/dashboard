Sequelize = require 'sequelize'
config = require('./config').sequelize.development

sequelize = new Sequelize(config.sequelize.name, null, null, config)

module.exports = sequelize