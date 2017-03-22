import React from 'react'
import {observable, toJS} from 'mobx'
import {crel, div, span, h3, h4, h5, text, input, select, br } from 'teact'
import {observer} from 'mobx-react'
import EditableText from './EditableText'


class UserDeviceProps extends React.Component
  constructor: (props) ->

  handleSave: (id, value) =>
    {editor} = @props
    console.log value
    editor.updateUserDefaultDashboard(id, value)


  render: ->
    {editor} = @props
    defaultDashboardTitle = 'N/A'
    if editor.device.get('defaultDashboardId') isnt null
      for dashboard in editor.dashboards when dashboard.uuid is editor.device.get('defaultDashboardId')
        defaultDashboardTitle = dashboard.title

    div className: 'title-editor', =>
      div style: {marginBottom: 15}, className: 'content', =>
        div style: {marginBottom: 8}, className: 'row center between middle', =>
          h5 'User Device'
          crel EditableText,
            id: 'name'
            type: 'h4'
            text: editor.device.get('name')
            onSave: @handleSave
        div className: 'row between middle', =>
          div 'Location'
          crel EditableText,
            id: 'location'
            type: 'div'
            text: editor.device.get('location')
            onSave: @handleSave
        div className: 'row center between middle', =>
          div 'Device Type'
          div editor.device.get('type')
        div className: 'row center between middle', =>
          div 'IP Address'
          div editor.device.get('ip')
        div className: 'row center between middle', =>
          div 'Device Height'
          div editor.device.get('height') + 'px'
        div className: 'row center between middle', =>
          div 'Device Width'
          div editor.device.get('width') + 'px'
        div className: 'row center between middle', =>
          div 'Default Dashboard'
          div defaultDashboardTitle

export default (observer(UserDeviceProps))

