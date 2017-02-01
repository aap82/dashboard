module.exports =  (req, res, next) =>
  if req.url is '/editor' and req.device.type is 'desktop'
    return next()
  else if req.url is '/dashboard' and req.device.type in ['tablet', 'phone']
    return next()
  else if req.device.type is 'desktop'
    res.redirect '/editor'
  else if req.device.type in ['tablet', 'phone']
    res.redirect '/dashboard'
  else
    res.sendStatus(404)
