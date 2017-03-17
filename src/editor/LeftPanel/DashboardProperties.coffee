React = require 'react'
{crel, div, select, option, br } = require 'teact'
{ inject, observer} = require 'mobx-react'
MenuButton = require './../components/MenuButton'
{ Button} = require('@blueprintjs/core')
ColorPickerComponent = require './ColorPicker'

class DashboardDeviceOrientation extends React.Component
  changeDeviceOrientation: (e) =>
    {editor} = @props
    editor.setDashboardOrientationTo(e.target.value)

  render: ->
    {editor} = @props
    div =>
      div className: 'row between middle', =>
        div 'Device Orientation'
        div className: 'pt-select', =>
          select onChange: @changeDeviceOrientation, value: editor.dashboardOrientation, disabled: !editor.isEditing, ->
            option key: 'landscape', value: 'landscape', "Landscape"
            option key: 'portrait', value: 'portrait', "Portrait"




DashboardDeviceOrientation = observer(DashboardDeviceOrientation)

class DashboardProperties extends React.Component

  render: ->
    {editor} = @props
    {dashboard, isEditing} = editor
    div className: 'properties-section', ->
      div className: 'title-row button', ->
        crel Button,
          text: 'Dashboard'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div className: 'content', ->
        crel DashboardDeviceOrientation,
          editor: editor
        br()
        crel ColorPickerComponent,
          picker: dashboard,
          target: 'backgroundColor',
          alpha: false,
          isEditing: isEditing,
          label: 'Background Color'






module.exports = observer(DashboardProperties)










