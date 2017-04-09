import React from 'react'
import {observable, toJS} from 'mobx'
import {crel, div, span, h3, h4, h5, text, input, select, br } from 'teact'
import {inject, observer} from 'mobx-react'
import EditableText from './EditableText'


class UserDeviceProps extends React.Component
  constructor: (props) ->

  handleSave: (id, value) =>
    {editor} = @props
    console.log value
    editor.updateUserDefaultDashboard(id, value)


  render: ->
    {editor, dashboards, app} = @props
    {device, dashboard} = app
    defaultDashboardTitle = 'N/A'
    if device.get('defaultDashboardId') isnt null
      for dashboard in dashboards.values() when dashboard.uuid is device.get('defaultDashboardId')
        defaultDashboardTitle = dashboard.title

    div className: 'title-editor', =>
      div style: {marginBottom: 15}, className: 'content', =>
        div style: {marginBottom: 8}, className: 'row center between middle', =>
          h5 'User Device'
          crel EditableText,
            id: 'name'
            type: 'h4'
            label: 'User Device'
            text: device.get('name')
            onSave: @handleSave
        div className: 'row between middle', =>
          div 'Location'
          crel EditableText,
            id: 'location'
            type: 'div'
            text: device.get('location')
            onSave: @handleSave



UserDeviceProps = inject('app', 'dashboards')(observer(UserDeviceProps))
export default UserDeviceProps

