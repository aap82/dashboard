import React from 'react'
import {crel, div, input, li, label, select, option, text} from 'teact'
import {inject, observer} from 'mobx-react'
import ColorPicker from './components/ColorPicker'
import {DeviceOrientation, GridColumnUnits} from './components/Selects'
import NumberInput from './components/NumberInput'


GridColumns = observer(({grid, unitChange, valueChange}) ->
  div ->
    div className: "row middle between", ->
      div  "row middle start",->
        text "Columns Size by "
        crel GridColumnUnits, value: grid.colUnit, onChange: unitChange
      div className: "row end", ->
        div style: width: 75, ->
          crel NumberInput,
            value: grid.columns
            min: 1
            max: grid.width
            minorStepSize: 1
            majorStepSize: if grid.colUnit is 'pixel_width' then 25 else 4
            onChange: valueChange
    div style: {height: 20}, className: "row between middle", ->
      switch grid.colUnit
        when 'pixel_width'
          div "No of Columns"
          div className: "row end", ->
            div "#{grid.cols.toFixed(0)} "
            div " cols"
        else
          div "Column Width (approx)"
          div className: "row end", ->
            div "#{grid.colWidth.toFixed(2)} "
            div " px"

)


GridNumberChange = observer(({primaryLabel, secondaryLabel, store, property, onChange}) ->
  div className: "row middle between", ->
    div  "row middle start",->
      text "#{primaryLabel}"
      text "#{secondaryLabel}"
    div className: "row end", ->
      div style: width: 75, ->
        crel NumberInput,
          value: store[property],
          min: 1
          max: 1200
          majorStepSize: 1
          onChange: onChange
)






class GridProperties extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {grid} = @props
    div style: {marginBottom: 10}, =>
      div className: 'settings-row'
      div className: 'settings-row', =>
        crel DeviceOrientation, grid: grid, onChange: @orientationChange
      div className: 'settings-row', =>
        crel ColorPicker,
          title: "BackgroundColor"
          store: grid
          property: "backgroundColor"
          onChange: @backgroundColorChange
      div className: 'settings-row', =>
        crel GridColumns,
          grid: grid
          unitChange: @handleGridColumnUnitChange
          valueChange: @handleGridColumnValueChange
      div className: 'settings-row', =>
        crel GridNumberChange,
          primaryLabel: "Row Height"
          secondaryLabel: "  (px)"
          onChange: @handleRowHeightChange
          store: grid
          property: "rowHeight"
      div className: 'settings-row', =>
        crel GridNumberChange,
          primaryLabel: "Margin X "
          secondaryLabel: "  (px)"
          store: grid
          property: "marginX"
          onChange: @handleMarginXChange
      div className: 'settings-row', =>
        crel GridNumberChange,
          primaryLabel: "Margin Y "
          secondaryLabel: "  (px)"
          store: grid
          property: "marginY"
          onChange: @handleMarginYChange




  orientationChange: (e) => @props.grid.orientation = e.target.value
  backgroundColorChange: (color) => @props.grid.backgroundColor = color.hex
  handleGridColumnUnitChange: (e) => @props.grid.changeUnit e.target.value
  handleGridColumnValueChange: (v) => @props.grid.columns = v
  handleRowHeightChange: (v) => @props.grid.rowHeight = v
  handleMarginXChange: (v) => @props.grid.marginX = v
  handleMarginYChange: (v) => @props.grid.marginY = v


export default GridProperties 