import React from 'react'
import {crel, div, input, text} from 'teact'
import {inject, observer} from 'mobx-react'
import { SliderPicker} from 'react-color'
import AnimakitExpander from 'animakit-expander'
import {extendObservable} from 'mobx'

export ColorPickerSwatch = observer((props) ->
  displayName: "ColorPickerSwatch"
  styles =
    color: {
      width: '36px',
      height: '14px',
      borderRadius: '2px',
      background: "#{props.color}"
    },
    swatch: {
      padding: '2px',
      background: '#fff',
      borderRadius: '1px',
      boxShadow: '0 0 0 1px rgba(0,0,0,.1)',
      display: 'inline-block',
      cursor: 'pointer',
    }
  div style: styles.swatch, onClick: props.onClick, ->
    div style: styles.color

)

export ColorPickerSlider = observer((props) ->
  displayName: "ColorPickerSlider"
  crel SliderPicker,
    onComplete: props.onComplete
    onChange: props.onChange
    color: hex: props.color

)



export ColorPicker = inject('panel')(observer(class ColorPicker extends React.Component
  constructor: (props) ->
    super props
    extendObservable @, {isOpen: no}
  togglePanel: =>   @isOpen = !@isOpen
  enableDrag: => @props.panel.enableDrag()
  disableDrag: => @props.panel.disableDrag()

  render: ->
    {title, store, property, onChange} = @props
    div =>
      div onClick: @togglePanel, className: 'row middle between', =>
        text "#{title}"
        crel ColorPickerSwatch,
          color: store[property]
#      crel AnimakitExpander,
#        expanded: @isOpen
#        duration: 250, =>
      div style: {paddingRight: 5, paddingLeft: 5, marginBottom: 10, marginTop: 10}, =>
        div onMouseDown: @disableDrag, onMouseUp: @enableDrag, =>
          crel ColorPickerSlider,
            color: store[property]
            onChange: onChange
            onComplete: @enableDrag

))

export default ColorPicker