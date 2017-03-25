getenv = require('getenv')
API_KEY = getenv('DARKSKY_KEY')
LAT = getenv('LATITUDE')
LON = getenv('LONGITUDE')
DarkSky = require 'dark-sky'
forecast = new DarkSky(API_KEY)
Weather = require './model'

exports.updateDataForecast = ->
  forecast
  .latitude(LAT)
  .longitude(LON)
  .exclude('minutely, flags, alerts')
  .get()
  .then (_data) ->
    _data.hourly.data[i].time = (hour.time + _data.offset * 3600 ) * 1000 for hour,i in _data.hourly.data
    _data.daily.data[i].time = (day.time + _data.offset * 3600 ) * 1000 for day,i in _data.daily.data
    _data.currently.time = (_data.currently.time + _data.offset * 3600 ) * 1000
    Weather.summary =
        current: _data.hourly.summary
        currentIcon: _data.hourly.icon
        extended: _data.daily.summary
        extendedIcon: _data.daily.icon
    Weather.currently = _data.currently
    Weather.hourly = _data.hourly.data
    Weather.daily = _data.daily.data
    return Weather
  .catch (err) ->
    console.log err
    return null


