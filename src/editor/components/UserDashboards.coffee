import React from 'react'
import {extendObservable, computed} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br } from 'teact'
import {inject, observer} from 'mobx-react'
import { Button, Intent, Checkbox} from  '@blueprintjs/core'





DashboardDropDownListView = observer(({editor, dashboards, onChange}) =>
  displayName: 'SelectDashboardListView'
  div className: 'pt-select pt-large pt-fill', ->
    select value: editor.selectedDashboardId, onChange: onChange, disabled: editor.isEditing, ->
      option value: '0', 'Select/Create Dashboard'
      editor.deviceDashboards.map (dashboard) ->
        option key: dashboard.uuid, value: dashboard.uuid, "#{dashboard.title}" #" / #{dashboard.deviceType}"
)






class UserDashboardsSection extends React.Component
  constructor: (props) ->
    super props
    extendObservable @, {
      value: '0'
      isDefault: computed(=> @value is props.editor.device.get('defaultDashboardId'))

    }

  onChange: (e) =>
    {editor} = @props
    editor.selectedDashboardId = e.target.value
    @value = e.target.value
    editor.load(e.target.value)

  createDashboard: =>
    @props.modal.open('addDashboard')
    return
  deleteDashboard: =>
    @props.editor.delete()
    return

  toggleDefaultDashboard: =>
    {editor} = @props
    return if editor.dashboard.widgets.length is 0
    uuid = if @isDefault then null else @value
    editor.updateUserDefaultDashboard('defaultDashboardId', uuid)


  render: ->
    {editor, dashboards} = @props
    div style: {paddingLeft: 10, paddingRight: 10}, className: 'content', =>
      div style: {marginBottom: 10}, className: 'row between middle', =>
        div style: {width: '70%'}, =>
          crel DashboardDropDownListView, dashboards: dashboards, editor: editor, onChange: @onChange
        if @value is '0'
          crel Button,
            text: 'Create'
            disabled: editor.isEditing
            className: 'pt-large'
            intent: Intent.SUCCESS
            onClick: @createDashboard
        else
          crel Button,
            text: 'Delete'
            className: 'pt-large'
            intent: Intent.DANGER
            onClick: @deleteDashboard
            disabled: (editor.selectedDashboardId is '0' or editor.isEditing)
      div className: 'row between middle', =>
        div style: {width: '70%'}, =>
          crel Checkbox,
            checked: @isDefault
            label: 'Set to Default Dashboard?'
            onChange: @toggleDefaultDashboard
            disabled: (@value is '0')








UserDashboardsSection = inject('modal', 'dashboards', 'editor')(observer(UserDashboardsSection))
export default UserDashboardsSection


