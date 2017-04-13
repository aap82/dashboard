import React from 'react'
import {crel, div, text} from 'teact'
import WeatherIcon from './components/Icon'
import {inject, observer} from 'mobx-react'





CurrentWeather = inject('time', 'weather')(observer(({time, weather}) ->
  {currently, summary, daily} = weather

  div className: 'widget column weather between', ->
    div ->
      div style: {marginTop: 3, marginBottom: 10, paddingTop: 4, paddingBottom: 4, fontSize: 12}, className: 'row middle around', ->
        div ->
          text "Humidity:  "
          text "#{Math.floor(((currently.humidity * 100) or 0))}%"
        div ->
          text "Feels:  "
          text "#{Math.floor(((currently.apparentTemperature) or 0))}°"
      div style: {marginTop: 0, marginBottom: 15}, className: 'row center middle', ->
        div className: 'icon', style: {marginRight: 10}, ->
          crel WeatherIcon, iconName: currently.icon, size: '2x'
        div className: 'temp',  style: {marginRight: 0, marginLeft: 10}, ->
          text "#{Math.floor(currently.temperature) + 1}°"
        div className: 'text',  style: {marginRight: 0, marginLeft: 10}, ->
          text "#{currently.summary}"
      div style: {fontSize: 12}, className: 'row middle center', ->
        div "Forecast for #{time.formatTime(daily[0].time, 'ddd MM/DD:')}"
      div style: {marginBottom: 5}, className: 'row middle center', ->
        div "#{summary.current}"

    div style: {marginBottom: 0, fontSize: 'small'}, className: 'row middle center', ->
      text 'Last Updated: ' +  "#{time.formatTime(currently.time)}"

))


export default CurrentWeather