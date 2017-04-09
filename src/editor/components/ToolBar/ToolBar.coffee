import React from 'react'
import {crel, div, input, h4,  label, select, option, text,span} from 'teact'
import {inject, observer} from 'mobx-react'




DeviceOrientation = observer(class DeviceOrientation extends React.Component
  handleChange: (e) =>
    {device} = @props
    device.settings.grid.orientation = e.target.value
  render: ->
    {device} = @props
    {grid} = device.settings

    div className: 'pt-select pt-fill', =>
      select onChange: @handleChange, value: grid.orientation, =>
        option key: 'portrait', value: 'portrait', "Portrait"
        option key: 'landscape', value: 'landscape', "Landscape"

)









export default ToolBar = inject('editor')(observer(class ToolBar extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    {device, dashboard} = editor
    div style: {paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: '100%', color: 'white'}, className: 'pt-dark row middle between', =>
      crel DeviceOrientation,
        device: device

))

