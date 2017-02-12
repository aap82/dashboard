React = require 'react'
{crel, div, h2, h3, h4, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'
CreateNewDashboard = require '../components/CreateNewDashboard'
t = require './buttons/types'



class MenuButton extends React.Component
  render: ->
    {buttons} = @props
    button = b for b in buttons when b.isVisible
    div className: button.display, id: button.id, onClick: @handleClick, ->
      crel Button,
        text: button.text
        className: button.className
        loading: button.loading
        iconName: button.iconName
        disabled: button.disabled
        intent: button.intent
  handleClick: (e) =>
    switch e.currentTarget.id
      when t.EDIT_DASHBOARD
        @props.editor.startEditing()
        break
      when t.DONE_EDITING
        @props.editor.stopEditing()
        break
      when t.DISCARD_DASHBOARD
        @props.editor.restore()
      when t.EXIT_EDITOR
        console.log 'hi'
        @props.editor.exit()
        break






MenuButton = observer(MenuButton)


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



class LeftPanel extends React.Component
  render: ->
    console.log 'render left panel'
    {editor, editorView} = @props
    {buttons} = editorView
    {EDIT_DASHBOARD,EXIT_EDITOR,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,DELETE_DASHBOARD,ADD_NEW_WIDGET, COPY_DASHBOARD } = buttons
    div className: 'pt-dark left-panel', =>
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel MenuButton, buttons: [EXIT_EDITOR, DONE_EDITING, DISCARD_CHANGES], editor: editorView
            h2 'Editor'
        div className: 'col-xs-6', =>
          div className: 'row around middle', =>
            crel MenuButton, buttons: [EDIT_DASHBOARD, SAVE_DASHBOARD], editor: editorView
            crel MenuButton, buttons: [COPY_DASHBOARD, DELETE_DASHBOARD], editor: editorView
      br()
      br()
      crel Title, editor: editorView
      br()
      crel MenuButton, buttons: [ADD_NEW_WIDGET], editor: editorView
      br()
      br()
      div className: 'dashboard-editor', ->
        crel DashboardProps, editor: editor, editorView: editorView
        crel BaseWidgetProperties, editor: editor, editorView: editorView




module.exports = inject('editor', 'viewState', 'editorView')(observer(LeftPanel))













