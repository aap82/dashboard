if process.env.NODE_ENV is 'production'
  module.exports = require('./prod')
else
  module.exports = require('./dev')
