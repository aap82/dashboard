#Webpack = require('webpack');
#WebpackDevServer = require('Server');
#webpackConfig = require('./webpack.config');
#
#compiler = Webpack(webpackConfig);
#server = new WebpackDevServer(compiler, {
#  stats: {
#    colors: true
#  }
#
#
#server.listen(8080, '127.0.0.1', function() {
#  console.log('Starting server on http://localhost:8080');
#});