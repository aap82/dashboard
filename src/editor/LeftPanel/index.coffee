React = require 'react'
{crel, div, h3, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'


CreateNewDashboard = require '../components/CreateNewDashboard'


Title = inject('editor')(observer(({editor, onChange}) ->
  h3 ->
    crel EditableText,
      className: ' pt-rtl dashboard-title ' + !editor.isEditing
      placeholder: editor.title
      value: editor.title
      disabled: !editor.isEditing
      selectAllOnFocus: yes
      onChange: onChange
))




class AddNewWidgetButton extends React.Component
  addNewWidget: => @props.modal.showAddNewWidgetDialog()
  render: ->
    {editor} = @props
    crel Button,
      text: 'Add Widget Now'
      iconName: 'add'
      onClick: @addNewWidget
      className: 'pt-large pt-fill'
      intent: Intent.SUCCESS
      disabled: !editor.isEditing

AddNewWidgetButton = inject('modal', 'editor')(AddNewWidgetButton)

class TitleEditor extends React.Component
  onTitleChange: (value) => @props.dashboard.setProp('title', value)
  render: ->
    {editor} = @props
    div className: 'row between middle', =>
      text 'Title'
      crel Title, editor: editor, onChange: @onTitleChange


class LeftPanelEditing extends React.Component
  stopEditing: =>   @props.dashboard.stopEditing()
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
  startEditing: => @props.dashboard.startEditing()
  deleteDashboard: =>
    @props.modal.showConfirmDashboardDeleteDialog()
  closeEditor: =>
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


inject('viewStore', 'editor','dashboard')(LeftPanelEditing)
inject('viewStore', 'dashboard', 'editor', 'modal')(LeftPanelNotEditing)


LeftPanel = observer(({editor}) ->
  div className: 'pt-dark left-panel', =>
    switch editor.isEditing
      when yes then crel LeftPanelEditing
      else crel LeftPanelNotEditing
    div className: 'title-editor', ->
      div className: 'content', ->
        crel TitleEditor, editor: editor
    div className: 'dashboard-editor', =>
      crel DashboardProps, editor: editor
      crel BaseWidgetProperties, editor: editor
      br()
      br()

      crel AddNewWidgetButton
)




module.exports = inject('editor')(observer(LeftPanel))


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










