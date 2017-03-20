React = require 'react'
{extendObservable, computed} = require 'mobx'
{crel, div, text, label, button, select, option, pureComponent,br } = require 'teact'
{inject, observer} = require 'mobx-react'
{ Button, Intent, Checkbox} = require('@blueprintjs/core')





DashboardDropDownListView = observer(({editor, onChange}) =>
  displayName: 'SelectDashboardListView'
  div className: 'pt-select pt-large pt-fill', ->
    select value: editor.selectedDashboardId, onChange: onChange, disabled: editor.isEditing, ->
      option value: '0', 'Select Dashboard...'
      editor.getDashboardsForDevice().map (dashboard) ->
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
    ip = editor.device.get('ip')
    uuid = if @isDefault then null else @value
    editor.fetch('opName', 'UpdateUserDevice', {ip: ip, device: {defaultDashboardId: uuid}}).then (res) =>
      if res.data.updateUserDevice?
        {record} = res.data.updateUserDevice
        console.log record
        editor.updateDevice(record)
      else
        return


  render: ->
    {editor} = @props
    div style: {paddingLeft: 10, paddingRight: 10}, className: 'content', =>
      div style: {marginBottom: 10}, className: 'row between middle', =>
        div style: {width: '70%'}, =>
          crel DashboardDropDownListView, editor: editor, onChange: @onChange
        crel Button,
          text: 'Create'
          disabled: editor.isEditing
          className: 'pt-large'
          intent: Intent.SUCCESS
          onClick: @createDashboard
      div className: 'row between middle', =>
        div style: {width: '70%'}, =>
          crel Checkbox,
            checked: @isDefault
            label: 'Set to Default Dashboard?'
            onChange: @toggleDefaultDashboard
            disabled: (@value is '0')
        crel Button,
          text: 'Delete'
          className: 'pt-large'
          intent: Intent.DANGER
          onClick: @deleteDashboard
          disabled: (editor.selectedDashboardId is '0')








module.exports = inject('modal', 'editor')(observer(UserDashboardsSection))


