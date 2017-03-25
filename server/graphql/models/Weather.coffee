#{GraphQLList} = require 'graphql'
#mongoose = require('mongoose')
#Schema = mongoose.Schema
#composeWithMongoose = require('graphql-compose-mongoose').default
#{Resolver} = require('graphql-compose')
#
#
#
#
#
#
#HourlyWeatherSchema = new Schema({
#  "time": Date
#  "summary": String
#  "icon": String
#  "precipIntensity": Number
#  "precipProbability": Number
#  "temperature": Number
#  "apparentTemperature": Number
#  "dewPoint": Number
#  "humidity": Number
#  "windSpeed": Number
#  "windBearing": Number
#  "visibility": Number,
#  "cloudCover": Number
#  "pressure": Number
#  "ozone": Number
#})
#
#
#DailyWeatherSchema = new Schema({
#  "time": Date
#  "summary": String
#  "icon": String
#  "sunriseTime": Date,
#  "sunsetTime": Date,
#  "moonPhase": Number
#  "precipIntensity": Number
#  "precipIntensityMax": Number
#  "precipProbability":Number
#  "temperatureMin": Number
#  "temperatureMinTime": Date,
#  "temperatureMax": Number
#  "temperatureMaxTime": Date,
#  "apparentTemperatureMin": Number
#  "apparentTemperatureMinTime": Date,
#  "apparentTemperatureMax": Number
#  "apparentTemperatureMaxTime": Date,
#  "dewPoint": Number
#  "humidity": Number
#  "windSpeed": Number
#  "windBearing": Number
#  "visibility": Number,
#  "cloudCover": Number
#  "pressure": Number
#  "ozone": Number
#})
#
#CurrentWeatherSchema = new Schema({
#  "time": Date,
#  "summary": String
#  "icon": String
#  "nearestStormDistance": Number,
#  "nearestStormBearing": Number,
#  "precipIntensity": Number,
#  "precipProbability": Number,
#  "temperature": Number
#  "apparentTemperature": Number
#  "dewPoint": Number
#  "humidity": Number
#  "windSpeed": Number
#  "windBearing": Number
#  "visibility": Number
#  "cloudCover": Number
#  "pressure": Number
#  "ozone": Number
#})
#
#
#
#WeatherSchema = new Schema({
#  summary:
#    current: String
#    currentIcon: String
#    extended: String
#    extendedIcon:String
#  currently: CurrentWeatherSchema
#  hourly: [HourlyWeatherSchema]
#  daily: [DailyWeatherSchema]
#})
#
#Weather = mongoose.model 'Weather', WeatherSchema
#
#
#WeatherTC = composeWithMongoose(Weather)
#
#dailyQuery = Weather.findOne({})
#dailyQuery.select('daily')
#
#DailyType = WeatherTC.get('daily').getType()
#
#
#
#dailyWeather = new Resolver({
#  name: 'dailyWeather'
#  type: WeatherTC.get('daily').getType()
#  resolve: =>
#    dailyQuery.exec()
#
#
#})
#
#WeatherTC.addResolver(dailyWeather)
#
#module.exports =
#  Weather: Weather
#  WeatherTC: WeatherTC
##  HourlyWeatherTC: HourlyWeatherTC
##  DailyWeatherTC: DailyWeatherTC
