fetch = require 'node-fetch'
URL = "http://192.168.1.10:5000/by-id/d2c6"


MTASchedule = require '../types/mta'

MTAScheduleQuery =
  type: MTASchedule
  resolve: ->
    fetch(URL).then((res) -> res.json())


module.exports = MTAScheduleQuery