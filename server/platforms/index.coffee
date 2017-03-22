Store = require '../store'


require('./pimatic/updates').start(Store)
require('./nest/updates').start(Store)
module.exports = Store
