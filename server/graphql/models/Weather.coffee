mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default


HourlyWeather= new Schema({
  "time": Date
  "summary": String
  "icon": String
  "precipIntensity": Number
  "precipProbability": Number
  "temperature": Number
  "apparentTemperature": Number
  "dewPoint": Number
  "humidity": Number
  "windSpeed": Number
  "windBearing": Number
  "visibility": Number,
  "cloudCover": Number
  "pressure": Number
  "ozone": Number
})

DailyWeather = new Schema({
  "time": Date
  "summary": String
  "icon": String
  "sunriseTime": Date,
  "sunsetTime": Date,
  "moonPhase": Number
  "precipIntensity": Number
  "precipIntensityMax": Number
  "precipProbability":Number
  "temperatureMin": Number
  "temperatureMinTime": Date,
  "temperatureMax": Number
  "temperatureMaxTime": Date,
  "apparentTemperatureMin": Number
  "apparentTemperatureMinTime": Date,
  "apparentTemperatureMax": Number
  "apparentTemperatureMaxTime": Date,
  "dewPoint": Number
  "humidity": Number
  "windSpeed": Number
  "windBearing": Number
  "visibility": Number,
  "cloudCover": Number
  "pressure": Number
  "ozone": Number
})

CurrentWeather = new Schema({
  "time": Date,
  "summary": String
  "icon": String
  "nearestStormDistance": Number,
  "nearestStormBearing": Number,
  "precipIntensity": Number,
  "precipProbability": Number,
  "temperature": Number
  "apparentTemperature": Number
  "dewPoint": Number
  "humidity": Number
  "windSpeed": Number
  "windBearing": Number
  "visibility": Number
  "cloudCover": Number
  "pressure": Number
  "ozone": Number
})

Weather = new Schema({
  summary: String
  extendedSummary: String
  current: CurrentWeather
  hourly: [HourlyWeather]
  daily: [DailyWeather]
})

