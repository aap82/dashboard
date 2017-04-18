import React from 'react'
import {crel, div, input, text,button} from 'teact'
import {inject, observer} from 'mobx-react'
import { SliderPicker, ChromePicker} from 'react-color'
import {extendObservable} from 'mobx'
import {expr} from 'mobx'




export ColorPicker = inject('panel')(class ColorPicker extends React.Component
  render: ->
    {id, title, store, property, onChange, settings} = @props
    div =>
      div className: 'row middle between', style: {cursor: 'pointer',marginBottom: 5, marginTop: 5, height: 20}, onClick: @togglePanel, =>
        text "#{title}"
        crel ColorPickerSwatch,
          id: id
          settings: settings
          store: store
          property: property
      div className: 'row end', =>
        crel ChromePickerPanel,
          id: id
          settings: settings
          store: store
          property: property
          onChange: onChange
          onMouseDown: @disableDrag,
          onMouseUp: @enableDrag


  togglePanel: =>
    if  @props.settings.openPicker is @props.id
      @props.settings.openPicker = null
    else
      @props.settings.openPicker = @props.id

  enableDrag: => @props.panel.enableDrag(@props.panelID)
  disableDrag: => @props.panel.disableDrag(@props.panelID)

)

export default ColorPicker





ChromePickerPanel = observer((props)->
  isOpen = expr(-> props.settings.openPicker is props.id)
  color = props.store[props.property]
  popover =
    position: 'absolute',
    zIndex: '200000'
  if isOpen
    div style: popover, onMouseDown: props.onMouseDown, onMouseUp: props.onMouseUp, ->
      div style: height: 5
      crel ChromePicker,
        color: hex: color
        disableAlpha: yes
        onChange: props.onChange
  else
    null

)


ColorPickerSwatch = observer((props) ->
  displayName: "ColorPickerSwatch"
  isOpen = expr(-> props.settings.openPicker is props.id)
  if isOpen
    div style: color: '#ff0000', fontWeight: 600, marginTop: 3, ->
      text "Click to Close"
  else
    color = props.store[props.property]
    styles =
      color: {
        width: '36px',
        height: '14px',
        borderRadius: '2px',
        background: "#{color}"
      },
      swatch: {
        background: '#fff'
        padding: '2px'
        borderRadius: '1px',
        boxShadow: '0 0 0 1px rgba(0,0,0,.1)',
        display: 'inline-block',
        cursor: 'pointer'
      }
    div ->
      button style: styles.swatch, ->
          div style: styles.color








)
