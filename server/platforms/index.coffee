Store = require '../store'


require('./pimatic/updates').start(Store)

module.exports = Store
