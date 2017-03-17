React = require 'react'
{crel, div, h2, h3, h4, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'
CreateNewDashboard = require '../components/CreateNewDashboard'
t = require './buttons/types'
MenuButton = require './../components/MenuButton'
UserDeviceTitle = require '../components/UserDeviceTitle'

class LeftPanel extends React.Component
  render: ->
    console.log 'render left panel'
    {editor} = @props
    {buttons, dashboard} = editor
    {EDIT_DASHBOARD,EXIT_EDITOR,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,DELETE_DASHBOARD,COPY_DASHBOARD,CREATE_DASHBOARD } = buttons
    div className: 'pt-dark left-panel', =>
      crel UserDeviceTitle, editor: editor
      br()
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel MenuButton, buttons: [EXIT_EDITOR], editor: editor, onClick: @handleClick
            h2 'Editor'
        div className: 'col-xs-6', =>
          div className: 'row around middle', =>
            crel MenuButton, buttons: [EDIT_DASHBOARD, SAVE_DASHBOARD, DONE_EDITING], editor: editor, onClick: @handleClick
            crel MenuButton, buttons: [COPY_DASHBOARD, DELETE_DASHBOARD, DISCARD_CHANGES ], editor: editor, onClick: @handleClick
      br()
      br()
      crel MenuButton, buttons: [CREATE_DASHBOARD], editor: editor, onClick: @handleClick
      br()
      br()
      crel Title, editor: editor
      br()
      div className: 'dashboard-editor', ->
        crel DashboardProps, editor: editor
        crel BaseWidgetProperties, editor: editor


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







Title = observer(({editor}) ->
  {dashboard} = editor
  div className: 'title-editor', ->
    div className: 'content', ->
      div className: 'row between middle', ->
        h4 'Title'
        h3 ->
          crel EditableText,
            className: ' pt-rtl pt-fill pt-align-right'
            placeholder: dashboard.title
            value: dashboard.title
            disabled: !editor.isEditing
            selectAllOnFocus: yes
            onChange: ((value) => dashboard.title = value)
            intent: if dashboard.isEditing then Intent.PRIMARY else Intent.NONE
)
Title.displayName = 'TitleEditor'
module.exports = inject('editor', 'modal')(observer(LeftPanel))













