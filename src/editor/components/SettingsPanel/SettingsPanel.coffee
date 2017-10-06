import React from 'react'
import {crel, div, input, li, label, h6, text, br, button} from 'teact'
import {inject, observer} from 'mobx-react'
import ColorPicker from './components/ColorPicker'
import {DeviceOrientation} from './components/Selects'
import NumberInput from './components/NumberInput'
import cx from 'classnames'
import {expr} from 'mobx'

NumberChange = observer(({label, store, property, onChange, min, max}) ->
  div className: "row middle between label", ->
    div ->
      text "#{label}"
    div className: "row end", ->
      div style: width: 75, ->
        crel NumberInput,
          value: store[property],
          min: min
          max: max
          majorStepSize: 1
          onChange: onChange
)

class SettingsPanel extends React.Component
  constructor: (props) ->
    super props
  render: ->
    {settings, panels, editor} = @props
    {grid, widgetStyle} = settings
    div className: "column between settings-panel", =>
      div =>
        div style: {paddingTop: 10}, className: 'settings-row title', =>
          h6 'Grid Settings'
        div onMouseDown: @disableDrag, onMouseUp: @enableDrag, =>
          div className: 'settings-row content', =>
            crel DeviceOrientation, grid: grid, onChange: @orientationChange
          div className: 'settings-row content', =>
            crel ColorPicker,
              id: 'grid'
              title: "BackgroundColor"
              property: "backgroundColor"
              settings: panels.settings
              store: grid
              togglePicker: @togglePicker
              onChange: @backgroundColorChange
              enableDrag: @enableDrag
              disableDrag: @disableDrag
        div style: {marginTop: 10}, className: 'settings-row title', =>
            h6 'Widget Style Settings'
        div onMouseDown: @disableDrag, onMouseUp: @enableDrag, =>
          div className: 'settings-row content', =>
            crel NumberChange,
              label: "Border Radius (px)"
              onChange: @handleBorderRadiusChange
              store: widgetStyle
              property: "borderRadius"
              min: 0
              max: 25
          div className: 'settings-row content', =>
            crel NumberChange,
              label: "Card Depth"
              onChange: @handleCardDepthChange
              store: widgetStyle
              property: "cardDepth"
              min: 0
              max: 5
          div className: 'settings-row content', =>
            crel ColorPicker,
              id: 'widgetStyle'
              title: "BackgroundColor"
              property: "backgroundColor"
              settings: panels.settings
              store: widgetStyle
              togglePicker: @togglePicker
              onChange: @handleWidgetBackgroundColorChange
              enableDrag: @enableDrag
              disableDrag: @disableDrag




  closeColorPicker: =>
    {settings} = @props.panels
    settings.openPicker = null


  enableDrag: =>
    @props.panel.enableDrag("settings")
  disableDrag: =>
    @props.panel.disableDrag("settings")
  togglePicker: (e) =>
    {settings} = @props.panels
    if  settings.openPicker is e.target.id
      @closeColorPicker()
    else
      settings.openPicker = e.target.id
  orientationChange: (e) => @props.settings.grid.orientation = e.target.value
  backgroundColorChange: (color) => @props.settings.grid.backgroundColor = color.hex
  handleWidgetBackgroundColorChange: (color) => @props.settings.widgetStyle.backgroundColor = color.hex
  handleBorderRadiusChange: (v) => @props.settings.widgetStyle.borderRadius = v
  handleCardDepthChange: (v) => @props.settings.widgetStyle.cardDepth = v





export default SettingsPanel