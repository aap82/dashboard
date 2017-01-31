Sequelize = require 'sequelize'
config = require('./config').sequelize

sequelize = new Sequelize(config.name, null, null, config.development)

module.exports = sequelize