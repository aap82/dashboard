React = require 'react'
{crel, div, select, option, br } = require 'teact'
{ observer} = require 'mobx-react'
{ Button} = require('@blueprintjs/core')
{DashboardColorPicker} = require './ColorPicker'

DeviceType = (observer(({editor, onChange}) ->
  div ->
    div className: 'pt-select', ->
      select onChange: onChange, value: editor.deviceType, disabled: !editor.isEditing, ->
        option value: '', ''
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'

))


class DeviceTypeEditor extends React.Component
  onDeviceTypeChange: (e) => @props.editor.setProp('deviceType', e.target.value)
  render: ->
    {editor} = @props
    div className: 'row between middle', =>
      crel 'div', 'Device Type'
      crel DeviceType, editor: editor, onChange: @onDeviceTypeChange

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










