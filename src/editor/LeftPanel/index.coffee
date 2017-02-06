React = require 'react'
{crel, div, h3, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'


CreateNewDashboard = require '../components/CreateNewDashboard'


Title = observer(({editor, dashboard, onChange}) ->
  h3 ->
    crel EditableText,
      className: ' pt-rtl dashboard-title ' + !editor.isEditing
      placeholder: dashboard.title
      value: dashboard.title
      disabled: !editor.isEditing
      selectAllOnFocus: yes
      onChange: onChange
)




class AddNewWidgetButton extends React.Component
  addNewWidget: => @props.editorView.showAddNewWidgetDialog()
  render: ->
    {editor} = @props
    crel Button,
      text: 'Add Widget Now'
      iconName: 'add'
      onClick: @addNewWidget
      className: 'pt-large pt-fill'
      intent: Intent.SUCCESS
      disabled: !editor.isEditing

AddNewWidgetButton = inject('editorView')(AddNewWidgetButton)

class TitleEditor extends React.Component
  onTitleChange: (value) => @props.dashboard.setProp('title', value)
  render: ->
    {dashboard, editor} = @props
    div className: 'row between middle', =>
      text 'Title'
      crel Title, editor: editor, dashboard: dashboard, onChange: @onTitleChange


class LeftPanelEditing extends React.Component
  stopEditing: =>   @props.editor.stopEditing()
  saveDashboard: => @props.editorView.saveDashboard()
  discardChanges: =>
    @props.editor.setLayout()
    @props.editorView.showDiscardDashboardChangesDialog()
  render: ->
    {editor} = @props
    div =>
      div className: 'dashboard-editor-buttons', =>
        crel SaveDashboardButton, onClick: @saveDashboard
        crel DoneEditButton, onClick: @stopEditing
      br()
      div className: 'title-row-container middle', =>
        div className: 'middle between', =>
          h3 'Editor'
        div =>
          crel DiscardChangesButton, onClick: @discardChanges
      br()




class LeftPanelNotEditing extends React.Component
  startEditing: => @props.editor.startEditing()
  deleteDashboard: =>
    @props.editorView.showConfirmDashboardDeleteDialog()
  closeEditor: =>
    @props.editorView.close()
    @props.viewStore.showSetupPage()

  render: ->
    div =>
      crel ExitEditorButton, onClick: @closeEditor
      br()
      br()
      div className: 'title-row-container', =>
        div className: 'title-edit middle between', =>
          h3 'Editor'
          crel EditButton, onClick: @startEditing
        div =>
          crel DeleteDashboardButton, onClick: @deleteDashboard
      br()




LeftPanel = observer(({editor, dashboard, viewStore, editorView}) ->
  div className: 'pt-dark left-panel', =>
    switch editor.isEditing
      when yes then crel LeftPanelEditing, editorView: editorView, editor: editor
      else crel LeftPanelNotEditing, editorView: editorView, viewStore: viewStore, editor: editor
    div className: 'title-editor', ->
      div className: 'content', ->
        crel TitleEditor, dashboard: dashboard, editor: editor
    div className: 'dashboard-editor', =>
      crel DashboardProps, dashboard: dashboard, editor: editor
      crel BaseWidgetProperties, editor: editor
      br()
      br()

      crel AddNewWidgetButton, editor: editor
)




module.exports = inject('viewStore', 'editor', 'dashboard', 'editorView')(observer(LeftPanel))


EditButton = ({onClick}) ->
  crel Button,
    iconName: 'edit',
    onClick: onClick
    intent: Intent.PRIMARY
    text: 'Edit'



DeleteDashboardButton = ({onClick}) ->
  crel Button,
    text: 'Delete'
    iconName: 'delete'
    onClick: onClick
    intent: Intent.DANGER


ExitEditorButton = ({onClick}) ->
  crel Button,
    text: 'Exit'
    iconName: 'arrow-left'
    className: 'pt-large'
    onClick: onClick




SaveDashboardButton = ({onClick}) ->
  crel Button,
    text: 'Save'
    iconName: 'floppy-disk'
    intent: Intent.SUCCESS
    className: 'pt-large'
    onClick: onClick

DoneEditButton = ({onClick}) ->
  crel Button,
    text: 'Done'
    onClick: onClick
    className: 'pt-large'
#    intent: Intent.DANGER

DiscardChangesButton = ({onClick}) ->
  crel Button,
    text: 'Discard Changes'
    onClick: onClick
    className: 'pt-fill'
    intent: Intent.DANGER










