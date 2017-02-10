React = require 'react'
{crel, div, h2, h3, h4, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'
ButtonContainer = require '../components/ButtonContainer'
CreateNewDashboard = require '../components/CreateNewDashboard'


Title = observer(({editor, onChange}) ->
  h3 ->
    crel EditableText,
      className: ' pt-rtl pt-fill pt-align-right'
      placeholder: editor.title
      value: editor.title
      disabled: !editor.isEditing
      selectAllOnFocus: yes
      onChange: onChange
      intent: if editor.isEditing then Intent.PRIMARY else Intent.NONE
)
Title.displayName = 'TitleEditor'

class LeftPanel extends React.Component
  onTitleChange: (value) =>
    console.log value
    @props.editor.setProp('title', value)

  render: ->
    {editor} = @props
    {EDIT_DASHBOARD,EXIT_EDITOR,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,ADD_NEW_WIDGET, COPY_DASHBOARD } = editor.buttons
    titleChange = (value) => @props.editor.setProp('title', value)
    div className: 'pt-dark left-panel', =>
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel ButtonContainer, button: EXIT_EDITOR
            crel ButtonContainer, button: DONE_EDITING
            h2 'Editor'
        div className: 'col-xs-6', =>
          div className: 'row around middle', =>
            crel ButtonContainer, button: EDIT_DASHBOARD
            crel ButtonContainer, button: SAVE_DASHBOARD
            crel ButtonContainer, button: COPY_DASHBOARD
            crel ButtonContainer, button: DISCARD_CHANGES
      br()
      br()
      div className: 'title-editor', ->
        div className: 'content', ->
          div className: 'row between middle', ->
            h4 'Title'
            crel Title, editor: editor, onChange: titleChange
      br()
      br()
      div className: 'dashboard-editor', ->
        crel DashboardProps, editor: editor
        crel BaseWidgetProperties, editor: editor
        br()
        crel ButtonContainer, button: ADD_NEW_WIDGET





module.exports = inject('editor')(LeftPanel)













