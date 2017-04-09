import React from 'react'
import {crel, div, input, h4,  label, select, option, text,span} from 'teact'
import {inject, observer} from 'mobx-react'
import TextInput from '../TextInput'



DeviceOrientation = observer(class DeviceOrientation extends React.Component
  handleChange: (e) =>
    {settings} = @props
    settings.grid.orientation = e.target.value
  render: ->
    {grid} = @props.settings
    div className: 'pt-select pt-fill', =>
      select onChange: @handleChange, value: grid.orientation, =>
        option key: 'portrait', value: 'portrait', "Portrait"
        option key: 'landscape', value: 'landscape', "Landscape"

)


export default AppBar = inject('editor')(observer(class AppBar extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    {device, dashboard} = editor
    div style: {paddingLeft: 10, paddingRight: 10, height: '100%', color: 'white'}, className: 'pt-dark row middle between', =>
      crel DeviceTitle,
        element: 'h3'
        device: device,
        onConfirm: @handleDeviceTitleChange
      crel DashboardTitle,
        element: 'h4'
        dashboard: dashboard,
        onConfirm: @handleDashboardTitleChange


  handleDeviceTitleChange: (v) =>
    {device} = @props.editor
    device.name = v
  handleDashboardTitleChange: (v) =>
    {dashboard} = @props.editor
    dashboard.title = v
))






DeviceTitle = observer(({element, device, onConfirm}) ->
  div className: 'row middle', style: paddingLeft: 5, ->
    div ->
      span style: {color: "#5c7080"}, className: "pt-icon-standard pt-icon-info-sign"
    div style: marginLeft: 8, ->
      crel TextInput,
        element: element
        value: device.name
        onConfirm: onConfirm
)

DashboardTitle = observer(({element, dashboard, onConfirm}) ->
  div className: 'row middle', style: paddingLeft: 5, ->
    div ->
      crel TextInput,
        element: element
        value: dashboard.title
        onConfirm: onConfirm
)
