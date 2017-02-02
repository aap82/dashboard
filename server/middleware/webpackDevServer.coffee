getenv = require('getenv')
webpackDevMiddleware = require('webpack-dev-middleware')
webpack = require('webpack')

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'

module.exports = (app) ->
  webpackConfig = require('../../webpack/client.dev')
  compiler = webpack(webpackConfig)
  app.use(webpackDevMiddleware compiler, {
    host: SERVER_HOST
    historyApiFallback: true
    hot: false
    publicPath: webpackConfig.output.publicPath
    filename: webpackConfig.output.filename
    noInfo: false
    quiet: false
    contentBase: no
  })
  app.listen SERVER_PORT, ->
    console.log 'server listing at http://' + SERVER_HOST + ':' + SERVER_PORT
    return



