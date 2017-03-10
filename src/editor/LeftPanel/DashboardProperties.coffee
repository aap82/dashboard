React = require 'react'
{crel, div, select, option, br } = require 'teact'
{ observer} = require 'mobx-react'
{ Button} = require('@blueprintjs/core')
ColorPickerComponent = require './ColorPicker'

DeviceType = (observer(({dashboard, editor, onChange}) ->
  div ->
    div className: 'pt-select', ->
      select onChange: onChange, value: dashboard.deviceType, disabled: !editor.isEditing, ->
        option value: '', ''
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'

))


class DeviceTypeEditor extends React.Component
  onDeviceTypeChange: (e) =>
    {dashboard} = @props
    dashboard.deviceType = e.target.value
  render: ->
    {dashboard, editor} = @props
    div className: 'row between middle', =>
      crel 'div', 'Device Type'
      crel DeviceType, dashboard: dashboard, editor: editor, onChange: @onDeviceTypeChange


class DashboardProperties extends React.Component
  render: ->
    {editor} = @props
    {dashboard, isEditing} = editor
    {background} = dashboard
    div className: 'properties-section', ->
      div className: 'title-row button', ->
        crel Button,
          text: 'Dashboard'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div className: 'content', ->
        crel DeviceTypeEditor, dashboard: dashboard, editor: editor
        br()
        crel ColorPickerComponent, picker: background, isEditing: isEditing






module.exports = observer(DashboardProperties)










