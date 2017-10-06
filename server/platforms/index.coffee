Store = require '../store'
{updateDataForecast} = require './darksky'
updateDataForecast()

require('./pimatic/updates').start(Store)
module.exports = Store
