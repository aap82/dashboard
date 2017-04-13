import React from 'react'
import {crel, div, input, h4,  label, select, option, text,span} from 'teact'
import {inject, observer} from 'mobx-react'
import TextInput from '../TextInput'
import {Intent} from '@blueprintjs/core'


export default AppBar = inject('editor')(observer(class AppBar extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    {device} = editor
    div style: {paddingLeft: 10, paddingRight: 10, height: '100%', color: 'white'}, className: 'pt-dark row middle between', =>
      crel DeviceTitle,
        device: device,
        onConfirm: @handleDeviceTitleChange
      crel DashboardTitle,
        editor: editor,
        onConfirm: @handleDashboardTitleChange


  handleDeviceTitleChange: (v) =>
    {device} = @props.editor
    device.name = v
  handleDashboardTitleChange: (v) =>
    {editor} = @props
    editor.getDashboards().get(editor.selectedDashboardID).title = v
))






DeviceTitle = observer(({device, onConfirm}) ->
  div className: 'row middle', style: paddingLeft: 5, ->
    div ->
      span style: {color: "#5c7080"}, className: "pt-icon-standard pt-icon-info-sign"
    div style: marginLeft: 8, ->
      crel TextInput,
        element: 'h3'
        value: device.name
        onConfirm: onConfirm
        intent: Intent.PRIMARY

)

DashboardTitle = observer(({editor, onConfirm}) ->
  dashboard = editor.getDashboards().get(editor.selectedDashboardID)
  if dashboard?
    div className: 'row middle', style: paddingLeft: 5, ->
      div ->
        crel TextInput,
          element: 'h4'
          value: dashboard.title
          onConfirm: onConfirm
          intent: Intent.PRIMARY
  else
      div ->
        null
)
