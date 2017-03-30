import React from 'react'
import {crel, div} from 'teact'
import {inject, observer} from 'mobx-react'
import CurrentWeather from '../../widgets/WeatherWidgets/CurrentWeather'
import ReactGridLayout from 'react-grid-layout'

widgetStyle =
  position: 'relative'
  height: '100%'
  width: '100%'
  display: 'block'
  color: 'white'
  clear: 'both'
  backgroundColor: '#424647'
  fontSize: 18


class ScratchPad extends React.Component
  render: ->
    div className: 'setup-page', =>
      crel ReactGridLayout,
        isDraggable: yes
        isResizable: yes
        cols: 800
        width: 800
        rowHeight: 5
        , =>
          div key: '0', data: grid: {i: '0', w: 275, h: 12, x:350, y: 10, minW: 275, minH: 10}, =>
            div style: widgetStyle, className: 'base-widget z-depth-2', =>
              crel CurrentWeather


export default ScratchPad