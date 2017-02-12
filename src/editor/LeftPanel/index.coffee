React = require 'react'
{crel, div, h2, h3, h4, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'
ButtonContainer = require '../components/ButtonContainer'
CreateNewDashboard = require '../components/CreateNewDashboard'


class LeftPanel extends React.Component
  render: ->
    console.log 'render left panel'
    {editor, editorView} = @props
    {EDIT_DASHBOARD,EXIT_EDITOR,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,DELETE_DASHBOARD,ADD_NEW_WIDGET, COPY_DASHBOARD } = editorView.buttons
    div className: 'pt-dark left-panel', =>
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel ButtonContainer, button: EXIT_EDITOR
            crel ButtonContainer, button: DONE_EDITING
            crel ButtonContainer, button: DISCARD_CHANGES
            h2 'Editor'
        div className: 'col-xs-6', =>
          div className: 'row around middle', =>
            crel ButtonContainer, button: EDIT_DASHBOARD
            crel ButtonContainer, button: SAVE_DASHBOARD
            crel ButtonContainer, button: COPY_DASHBOARD
            crel ButtonContainer, button: DELETE_DASHBOARD
      br()
      br()
      div className: 'title-editor', ->
        div className: 'content', ->
          div className: 'row between middle', ->
            h4 'Title'
            crel Title, editor: editorView
      br()
      crel ButtonContainer, button: ADD_NEW_WIDGET
      br()
      br()
      div className: 'dashboard-editor', ->
        crel DashboardProps, editor: editor, editorView: editorView
        crel BaseWidgetProperties, editor: editor, editorView: editorView




Title = observer(({editor}) ->
  {dashboard} = editor
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


module.exports = inject('editor', 'viewState', 'editorView')(LeftPanel)













