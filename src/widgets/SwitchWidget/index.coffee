import {crel, div, text} from 'teact'
import React from 'react'
import Toggle from '../components/Toggle'
import Tappable from 'react-tappable/lib/Tappable'
import {attrNamesMap} from './props'


Switch = (props) ->
  {label, state, device} = props
  attrNames = attrNamesMap[device.platform]
  div className: 'widget switch-widget center', =>
    div className: 'title-container center middle',=>
      div className: 'widget-label-primary', label
    div className: 'switch-container center middle', =>
      crel Toggle, state: state, attr: attrNames.on



export class SwitchWidget extends React.Component
  render: ->
    crel Tappable, onTap: @sendCommand, =>
      crel Switch, @props

  sendCommand: => @props.sendCommand('toggle')


export class DimmerSwitchWidget extends React.Component
  render: ->
    crel Tappable, onTap: @sendCommand, onPress: @showDimmer =>
      crel Switch, @props

  sendCommand: => @props.sendCommand('toggle')

  showDimmer: => console.log 'hello'





