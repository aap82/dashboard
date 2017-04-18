import React from 'react'
import {crel, div, input, li, label, h6, text} from 'teact'
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


GridNumberChange = observer(({label, store, property, onChange}) ->
  div className: "row middle between", ->
    div  "row middle start",->
      text "#{label}"
    div className: "row end", ->
      div style: width: 75, ->
        crel NumberInput,
          value: store[property],
          min: 1
          max: 1200
          majorStepSize: 1
          onChange: onChange
)






class GridSettings extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {grid, settings} = @props
    div style: {marginBottom: 10}, =>
      div className: 'settings-row first', =>
        h6 'Grid Settings'
      div className: 'settings-row ', =>
        crel DeviceOrientation, grid: grid, onChange: @orientationChange
      div className: 'settings-row', =>
        crel ColorPicker,
          id: 'grid'
          panelID: 'settings'
          title: "BackgroundColor"
          property: "backgroundColor"
          settings: settings
          store: grid
          onChange: @backgroundColorChange
      div className: 'settings-row', =>
        crel GridColumns,
          grid: grid
          unitChange: @handleGridColumnUnitChange
          valueChange: @handleGridColumnValueChange
      div className: 'settings-row', =>
        crel GridNumberChange,
          label: "Row Height (px)"
          onChange: @handleRowHeightChange
          store: grid
          property: "rowHeight"




  orientationChange: (e) => @props.grid.orientation = e.target.value
  backgroundColorChange: (color) => @props.grid.backgroundColor = color.hex
  handleGridColumnUnitChange: (e) => @props.grid.changeUnit e.target.value
  handleGridColumnValueChange: (v) => @props.grid.columns = v
  handleRowHeightChange: (v) => @props.grid.rowHeight = v



export default GridSettings
