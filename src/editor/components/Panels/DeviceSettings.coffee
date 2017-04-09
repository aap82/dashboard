import React from 'react'
import {crel, div, input, text,span } from 'teact'
import {inject, observer} from 'mobx-react'
import Rnd from 'react-rnd'

import {Tree} from '@blueprintjs/core'
import {HuePicker} from 'react-color'

import { SketchPicker } from 'react-color'

class ColorPicker extends React.Component
  constructor: (props) ->
    super props
    @state =
      displayColorPicker: false,
      color:
        r: '0',
        g: '112',
        b: '19',
        a: '1',

  handleClick: (e) =>
    e.preventDefault
    console.log @props.panel.component
    newState = !@state.displayColorPicker
    @setState
      displayColorPicker: !@state.displayColorPicker
    @props.panel.moveAxis = if newState then  'none' else 'both'

  handleClose: =>
    @setState
      displayColorPicker: false
    @props.panel.moveAxis = 'both'

  handleChange: (color) =>
    console.log color
    @setState
      color: color.rgb


  render:->
    styles =
        color: {
          width: '36px',
          height: '14px',
          borderRadius: '2px',
          background: "rgba(#{ this.state.color.r }, #{ this.state.color.g }, #{ this.state.color.b }, #{ this.state.color.a })"
        },
        swatch: {
          padding: '2px',
          background: '#fff',
          borderRadius: '1px',
          boxShadow: '0 0 0 1px rgba(0,0,0,.1)',
          display: 'inline-block',
          cursor: 'pointer',
        },
        popover:
          position: 'absolute',
          zIndex: '50000',
          width: '100%'

        cover: {
          position: 'fixed',
          top: '0px',
          right: '0px',
          bottom: '0px',
          left: '0px',
        },

    div =>
      div style: styles.swatch, onClick: @handleClick, =>
        div style: styles.color
      switch @state.displayColorPicker
        when yes
          div style: styles.popover, =>
            div style: styles.cover, onClick: @handleClose
            crel HuePicker, color: @state.color, onChange: @handleChange
        else
          null

class FloatingPanel extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: =>
    @props.panel.component = @rnd

  render: ->
    {panel} = @props
    crel Rnd,
      ref: ((c) => @rnd = c)
      style:
        backgroundColor: '#232323'
        borderColor: 'black'
        borderWidth: 1
        borderStyle: 'solid'
      zIndex: 1
      className: 'z-depth-3'
      bounds: 'parent'
      initial: panel.initial
      minWidth: panel.minWidth
      maxWidth: panel.maxWidth
      minHeight: panel.minHeight
      maxWidth: panel.maxWidth
      maxHeight: panel.maxHeight
      moveAxis: panel.moveAxis, =>
        div =>
          div style: {
            cursor: 'pointer'
            zIndex: 500
          }, ->
            crel ColorPicker, panel: panel



FloatingPanel = observer(FloatingPanel)

Editor = inject('panel')(observer(({panel}) ->
  switch panel.isOpen
    when yes then crel FloatingPanel, panel: panel
    else
      null


))
export default Editor
