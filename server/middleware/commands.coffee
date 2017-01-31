express = require('express')
app = express()


app.use('/pimatic', require('../platforms/pimatic/commands'))


module.exports = app
