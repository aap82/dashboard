import React from 'react'
import {crel, div, input, text,button} from 'teact'
import {inject, observer} from 'mobx-react'
import { SliderPicker, ChromePicker} from 'react-color'
import {extendObservable} from 'mobx'
import {expr} from 'mobx'

getSwatchStyle = (color) ->
  color: {
    width: '36px',
    height: '14px',
    borderRadius: '2px',
    background: "#{color}"
    pointerEvents: 'none'
  },
  swatch: {
    background: '#fff'
    padding: '2px'
    borderRadius: '1px',
    boxShadow: '0 0 0 1px rgba(0,0,0,.1)',
    display: 'inline-block',
    cursor: 'pointer'
    pointerEvents: 'none'
  }
mainContainerStyle = {cursor: 'pointer',marginBottom: 5, marginTop: 5, height: 20}
ColorPicker = observer(({id, title, store, property, onChange, enableDrag, disableDrag, settings, togglePicker}) =>
  color = store[property]
  isOpen = (settings.openPicker is id)


  div ->
    div id: id, className: 'row middle between', style: mainContainerStyle, onClick: togglePicker, ->
      text "#{title}"
      if isOpen
        div style: color: '#ff0000', pointerEvents: 'inherit', fontWeight: 600, marginTop: 3, "Click to Close"
      else
        styles = getSwatchStyle(color)
        div id: id, style: styles.swatch, ->
          div style: styles.color
    div className: 'row end', ->
      if isOpen
        div onMouseDown: disableDrag,
          onMouseUp: enableDrag
          style:
            position: 'absolute'
            zIndex: '200000'
          ->
            div style: height: 5
            crel ChromePicker,
              color: hex: color
              disableAlpha: yes
              onChange: onChange
      else
        null

)


export default ColorPicker


#
#
#class ColorPicker extends React.Component
#  render: ->
#    {id, title, store, property, onChange, enableDrag, disableDrag, settings, togglePicker} = @props
#    div =>
#      div id: id, className: 'row middle between', style: {cursor: 'pointer',marginBottom: 5, marginTop: 5, height: 20}, onClick: togglePicker, =>
#        text "#{title}"
#        crel ColorPickerSwatch,
#          id: id
#          settings: settings
#          store: store
#          property: property
#      div className: 'row end', =>
#        crel ChromePickerPanel,
#          id: id
#          settings: settings
#          store: store
#          property: property
#          onChange: onChange
#          onMouseDown: disableDrag,
#          onMouseUp: enableDrag
#
#export default ColorPicker
#

#
#
#ChromePickerPanel = observer((props)->
#  isOpen = expr(-> props.settings.openPicker is props.id)
#  color = props.store[props.property]
#  popover =
#    position: 'absolute',
#    zIndex: '200000'
#  if isOpen
#    div style: popover, onMouseDown: props.onMouseDown, onMouseUp: props.onMouseUp, ->
#      div style: height: 5
#      crel ChromePicker,
#        color: hex: color
#        disableAlpha: yes
#        onChange: props.onChange
#  else
#    null
#
#)
#
#
#ColorPickerSwatch = observer((props) ->
#  displayName: "ColorPickerSwatch"
#  isOpen = expr(-> props.settings.openPicker is props.id)
#  if isOpen
#    div style: color: '#ff0000', pointerEvents: 'inherit', fontWeight: 600, marginTop: 3, ->
#      text "Click to Close"
#  else
#    color = props.store[props.property]
#    styles =
#      color: {
#        width: '36px',
#        height: '14px',
#        borderRadius: '2px',
#        background: "#{color}"
#        pointerEvents: 'none'
#      },
#      swatch: {
#        background: '#fff'
#        padding: '2px'
#        borderRadius: '1px',
#        boxShadow: '0 0 0 1px rgba(0,0,0,.1)',
#        display: 'inline-block',
#        cursor: 'pointer'
#        pointerEvents: 'none'
#      }
#    div id: props.id, style: styles.swatch, ->
#        div style: styles.color








#)
