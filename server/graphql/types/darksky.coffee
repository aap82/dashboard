{GraphQLList, GraphQLObjectType, GraphQLInt, GraphQLString, GraphQLList, GraphQLFloat} = require 'graphql'
Weather = require '../../platforms/darksky/model'

HourlyWeatherType = new GraphQLObjectType({
  name: 'HourlyWeatherType'
  fields: =>
    time: type: GraphQLFloat
    summary: type: GraphQLString
    icon: type: GraphQLString
    precipIntensity: type: GraphQLFloat
    precipProbability: type: GraphQLFloat
    precipAccumulation: type: GraphQLFloat
    precipType: type: GraphQLString
    temperature: type: GraphQLFloat
    apparentTemperature: type: GraphQLFloat
    dewPoint: type: GraphQLFloat
    humidity: type: GraphQLFloat
    windSpeed: type: GraphQLFloat
    windBearing: type: GraphQLFloat
    visibility: type: GraphQLFloat
    cloudCover: type: GraphQLFloat
    pressure: type: GraphQLFloat
    ozone: type: GraphQLFloat
})
HourlyWeather =
  type: new GraphQLList(HourlyWeatherType)
  args: first: GraphQLInt
  resolve: (obj, args) -> if args.first? then obj.hourly[0...args.first] else obj.hourly


DailyWeatherType = new GraphQLObjectType({
  name: 'DailyWeatherType'
  fields: =>
    time: type: GraphQLFloat
    summary: type: GraphQLString
    icon: type: GraphQLString
    sunriseTime: type: GraphQLFloat,
    sunsetTime: type: GraphQLFloat,
    moonPhase: type: GraphQLFloat
    precipIntensity: type: GraphQLFloat
    precipIntensityMax: type: GraphQLFloat
    precipProbability: type: GraphQLFloat
    temperatureMin: type: GraphQLFloat
    temperatureMinTime: type: GraphQLFloat
    temperatureMax: type: GraphQLFloat
    temperatureMaxTime: type: GraphQLFloat,
    apparentTemperatureMin: type: GraphQLFloat
    apparentTemperatureMinTime: type: GraphQLFloat,
    apparentTemperatureMax: type: GraphQLFloat
    apparentTemperatureMaxTime: type: GraphQLFloat,
    dewPoint: type: GraphQLFloat
    humidity: type: GraphQLFloat
    windSpeed: type: GraphQLFloat
    windBearing: type: GraphQLFloat
    visibility: type: GraphQLFloat,
    cloudCover: type: GraphQLFloat
    pressure: type: GraphQLFloat
    ozone: type: GraphQLFloat
})

DailyWeather =
  type: new GraphQLList(DailyWeatherType)
  args: first: GraphQLInt
  resolve: (obj, args) ->    if args.first? then obj.daily[0...args.first] else obj.daily

CurrentWeatherType =  new GraphQLObjectType({
  name: 'CurrentlyWeatherType'
  fields: =>
    time:
      type: GraphQLFloat
    precipType: type: GraphQLString
    summary: type: GraphQLString
    icon: type: GraphQLString
    nearestStormDistance: type: GraphQLFloat
    nearestStormBearing: type: GraphQLFloat
    precipIntensity: type: GraphQLFloat
    precipProbability: type: GraphQLFloat
    temperature: type: GraphQLFloat
    apparentTemperature: type: GraphQLFloat
    dewPoint: type: GraphQLFloat
    humidity: type: GraphQLFloat
    windSpeed: type: GraphQLFloat
    windBearing: type: GraphQLFloat
    visibility: type: GraphQLFloat
    cloudCover: type: GraphQLFloat
    pressure: type: GraphQLFloat
    ozone: type: GraphQLFloat
})



SummaryWeatherType = new GraphQLObjectType({
  name: 'SummaryWeatherType'
  fields: =>
    current: type: GraphQLString
    currentIcon: type: GraphQLString
    extended: type: GraphQLString
    extendedIcon: type: GraphQLString
})

WeatherType = new GraphQLObjectType({
  name: 'WeatherType'
  fields: =>
    summary: SummaryWeatherType
    currently: CurrentWeatherType
    hourly: HourlyWeather
    daily: DailyWeather
})



module.exports =
    type: WeatherType
    resolve: => return Weather

