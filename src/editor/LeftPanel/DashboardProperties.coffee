React = require 'react'
{crel, div, select, option, br } = require 'teact'
{ observer} = require 'mobx-react'
{ Button} = require('@blueprintjs/core')
{DashboardColorPicker} = require './ColorPicker'

DeviceType = (observer(({editor, onChange}) ->
  {dashboard} = editor
  div ->
    div className: 'pt-select', ->
      select onChange: onChange, value: dashboard.deviceType, disabled: !editor.isEditing, ->
        option value: '', ''
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'

))


class DeviceTypeEditor extends React.Component
  onDeviceTypeChange: (e) =>
    {dashboard} = @props.editorView
    dashboard.deviceType = e.target.value
  render: ->
    {editorView} = @props
    div className: 'row between middle', =>
      crel 'div', 'Device Type'
      crel DeviceType, editor: editorView, onChange: @onDeviceTypeChange

DashboardProperties = (props) ->
  div className: 'properties-section', ->
    div className: 'title-row button', ->
      crel Button,
        text: 'Properties'
        iconName: 'caret-down'
        className: 'pt-minimal pt-fill pt-large'
    div className: 'content', ->
      crel DeviceTypeEditor, props
      crel DashboardColorPicker, props
      br()





module.exports = DashboardProperties










