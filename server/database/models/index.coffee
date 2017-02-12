sequelize = require '../sequelize'
{Dashboard} = require './Dashboard'


exports = module.exports




#exports.connect = (app) => sequelize.sync().then(=> return app)
exports.connect = => sequelize.sync()
exports.init_database = => sequelize.sync()



exports.Dashboard = Dashboard


