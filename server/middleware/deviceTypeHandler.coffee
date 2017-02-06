express = require('express')
app = express()

app.post '*', (req, res, next) =>
  console.log req.url
  next()

app.get '*', (req, res, next) =>
  if req.url in ['/graphql']
    return next()
  if req.url in ['/editor', '/graphiql', '/graphql'] and req.device.type is 'desktop'
    return next()
  else if req.url is '/dashboard' and req.device.type in ['tablet', 'phone']
    return next()
  else if req.device.type is 'desktop'
    res.redirect '/editor'
  else if req.device.type in ['tablet', 'phone']
    res.redirect '/dashboard'
  else
    res.sendStatus(404)


module.exports = app