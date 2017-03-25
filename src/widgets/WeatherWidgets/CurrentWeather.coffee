import React from 'react'
import {crel, div, text} from 'teact'
import WeatherIcon from './components/Icon'
import {inject, observer} from 'mobx-react'





export default CurrentWeather = inject('weather')(observer(({weather}) ->
  {currently, summary} = weather

  div className: 'widget column weather', ->
    div style: {marginTop: 5, marginBottom: 15}, className: 'row center middle', ->
      div className: 'icon', style: {marginRight: 10}, ->
        crel WeatherIcon, iconName: currently.icon, size: '2x'
      div className: 'temp',  style: {marginRight: 0, marginLeft: 10}, ->
        text "#{Math.floor(currently.temperature) + 1}°"
      div className: 'text',  style: {marginRight: 0, marginLeft: 10}, ->
        text "Partly Cloudy"#{currently.summary}"
    div style: {marginBottom: 5}, className: 'row middle center', ->
      div "#{summary.current}"

))

#
#
#  div className: 'col-xs-3', ->
#    div className: 'row around middle', ->
#      div 'Hello'
#      div 'Hello'
#    div className: 'col-xs-6 center', ->
#      div className: 'column center middle around', ->
#        crel WeatherIcon, name: 'clear-day', size: '4x'
#        div 'Hello'
#    div className: 'col-xs-3', ->
#      div className: 'row around middle', ->
#        div 'Hello'
#        div 'Hello'
#
#
#
