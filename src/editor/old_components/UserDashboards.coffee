import React from 'react'
import {extendObservable, computed} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br, ul, li,h5, h6,input,span  } from 'teact'
import {inject, observer} from 'mobx-react'
import { Button, Intent, Checkbox} from  '@blueprintjs/core'
import Select from '../forms/components/Select'



class UserDashboardItem extends React.Component
  constructor: (props) ->
    super props

  handleClick: =>
    console.log @props.dashboard

  render: ->
    {dashboard} = @props
    li =>
      button type: 'button',
        className: 'pt-menu-item pt-active pt-intent-primary pt-icon-layout-grid'
        onClick: @handleClick, ->
          h6 "#{dashboard.title}"


UserDashboardList = observer(({device, dashboards}) =>
  ul className: 'pt-menu pt-elevation-1', ->
    li className: 'pt-menu-header', ->
      h5 'Dashboards'
    li className: 'pt-menu-header'
    device.get('dashboardIDs').map (id) ->
      crel UserDashboardItem,
        key: "#{id}"
        dashboard: dashboards.get(id)
      li className: 'pt-menu-header'
    li ->
      button type: 'button', className: 'pt-menu-item pt-icon-plus', ->
        h6 "Add New"
    li className: 'pt-menu-header'


)


DashboardDropDownListView = observer(({editor, device, dashboards, onChange}) =>
  displayName: 'SelectDashboardListView'
  div className: 'pt-select pt-fill', ->
    select value: editor.selectedDashboardId, onChange: onChange, disabled: editor.isEditing, ->
      option value: '0', 'Select/Create Dashboard'
      device.get('dashboardIDs').map (id) ->
        option key: dashboards.get(id).uuid, value: dashboards.get(id).uuid, "#{dashboards.get(id).title}" #" / #{dashboard.deviceType}"

)



SelectDashboards = ({ device, dashboards, form }) =>
  dashboards = ({value: dashboards.get(id).uuid, label: dashboards.get(id).title} for id in device.get('dashboardIDs'))
  crel Select,
    showLabel: yes
    large: no
    fill: yes
    inline: no
    field: form.$('selectDashboard')
    options: dashboards


class UserDashboardsSection extends React.Component
  constructor: (props) ->
    super props
    extendObservable @, {
      value: '0'
      isDefault: computed(=> @value is props.app.device.get('defaultDashboardId'))

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
    {app, forms} = @props
    {editor, device, dashboards} = app
    div style: {paddingLeft: 10, paddingRight: 10}, className: 'content', =>
#      div style: {marginBottom: 10}, className: 'row between middle', =>
#        div style: {width: '70%'}, =>
#          crel SelectDashboards, form: forms.selectDashboard, device: device, dashboards: dashboards
#      div style: {marginBottom: 10}, className: 'row between middle', =>
#        div style: {width: '70%'}, =>
#          crel DashboardDropDownListView, device: device, dashboards: dashboards, editor: editor, onChange: @onChange
#
#
#        if @value is '0'
#          crel Button,
#            text: 'Create'
#            disabled: editor.isEditing
#            intent: Intent.SUCCESS
#            onClick: @createDashboard
#        else
#          crel Button,
#            text: 'Delete'
#            intent: Intent.DANGER
#            onClick: @deleteDashboard
#            disabled: (editor.selectedDashboardId is '0' or editor.isEditing)
#      div className: 'row between middle', =>
#        div style: {width: '70%'}, =>
#          crel Checkbox,
#            checked: @isDefault
#            label: 'Set to Default Dashboard?'
#            onChange: @toggleDefaultDashboard
#            disabled: (@value is '0')

      crel UserDashboardList,  device: device, dashboards: dashboards








UserDashboardsSection = inject('modal','app', 'forms')(observer(UserDashboardsSection))
export default UserDashboardsSection


