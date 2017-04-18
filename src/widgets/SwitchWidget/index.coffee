import {crel, div, text} from 'teact'
import React from 'react'
import Toggle from '../components/Toggle'
import Tappable from 'react-tappable/lib/Tappable'


export SwitchProperties =
  defaultFont:
    primaryFont: 'default'



  label: yes
  layout:
    w: 100
    h: 100
    minW: 90
    minH: 90
  types: ['switch', 'dimmer']
  actions: yes
  attributes: ['on']
  attrNamesMap:
    pimatic:
      on: 'state'



#Switch = ({label, state, device} ) ->
Switch = ->
#  attrNames = SwitchProps.attrNamesMap[device.platform]
  div className: 'widget column switch-widget center middle', =>
    div style: {marginBottom: 5}, className: 'title-container center middle',=>
      div className: 'widget-label-primary', 'label'
    div style: {marginTop: 3},  className: 'center middle', =>
      crel Toggle, state: yes



export default class SwitchWidget extends React.Component
  render: ->
#    crel Tappable, onTap: @sendCommand, =>
     crel Switch, @props

#  sendCommand: => @props.sendCommand('toggle')


export class DimmerSwitchWidget extends React.Component
  render: ->
    crel Tappable, onTap: @sendCommand, onPress: @showDimmer =>
      crel Switch, @props

  sendCommand: => @props.sendCommand('toggle')

  showDimmer: => console.log 'hello'





