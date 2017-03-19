React = require 'react'
{crel, div, select, option, br, h4, h3 } = require 'teact'
{ inject, observer} = require 'mobx-react'
MenuButton = require './../components/MenuButton'
{ Button, Intent, EditableText} = require('@blueprintjs/core')
ColorPickerComponent = require './ColorPicker'
t = require './buttons/types'


Title = observer(({editor}) ->
  {dashboard} = editor

  div style: {paddingRight: 10}, className: 'row between middle', ->
    h4 'Title'
    h4 ->
      crel EditableText,
        className: 'pt-rtl pt-fill pt-align-right'
        placeholder: dashboard.title
        value: dashboard.title
        disabled: !editor.isEditing
        selectAllOnFocus: yes
        onChange: ((value) => dashboard.title = value)
        intent: if editor.isEditing then Intent.SUCCESS else Intent.NONE
)
class DashboardDeviceOrientation extends React.Component
  changeDeviceOrientation: (e) =>
    {editor} = @props
    editor.setDashboardOrientationTo(e.target.value)

  render: ->
    {editor} = @props
    div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 5}, =>
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
    {buttons, dashboard, isEditing} = editor
    {EDIT_DASHBOARD,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,DELETE_DASHBOARD,COPY_DASHBOARD,CREATE_DASHBOARD } = buttons
    div className: 'properties-section', =>
      br()
      div className: 'title-row button', =>
        crel Button,
          text: 'Dashboard'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div style: {padding: 5}, className: 'row between middle', =>
        crel MenuButton, buttons: [EDIT_DASHBOARD, SAVE_DASHBOARD, DONE_EDITING], editor: editor, onClick: @handleClick
        crel MenuButton, buttons: [COPY_DASHBOARD, DISCARD_CHANGES ], editor: editor, onClick: @handleClick
        crel MenuButton, buttons: [DELETE_DASHBOARD], editor: editor, onClick: @handleClick
      br()
      div style: {marginBottom: 12}, className: 'title-editor', =>
        crel Title, editor: editor
      crel DashboardDeviceOrientation,
        editor: editor
      br()
      br()
      div style: {paddingLeft: 5, marginRight: -7}, =>
        crel ColorPickerComponent,
          picker: dashboard,
          target: 'backgroundColor',
          alpha: false,
          isEditing: isEditing,
          label: 'Background Color'




  handleClick: (e) =>
    switch e.currentTarget.id
      when t.EDIT_DASHBOARD
        @props.editor.startEditing()
        break
      when t.DONE_EDITING
        @props.editor.stopEditing()
        break
      when t.DISCARD_DASHBOARD
        @props.editor.restoreSnapshot()
      when t.EXIT_EDITOR
        @props.editor.exit()
        break
      when t.SAVE_DASHBOARD
        @props.editor.save()
        break
      when t.DELETE_DASHBOARD
        @props.editor.delete()
        break





module.exports = observer(DashboardProperties)










