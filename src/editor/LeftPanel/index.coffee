React = require 'react'
{crel, div, h3, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'


CreateNewDashboard = require '../components/CreateNewDashboard'


Title = observer(({dashboard, onChange}) ->
  h3 ->
    crel EditableText,
      className: ' pt-rtl dashboard-title ' + !dashboard.isEditing
      placeholder: dashboard.title
      value: dashboard.title
      disabled: !dashboard.isEditing
      selectAllOnFocus: yes
      onChange: onChange
)




class AddNewWidgetButton extends React.Component
  addNewWidget: => @props.editor.showAddNewWidgetDialog()
  render: ->
    {dashboard} = @props
    crel Button,
      text: 'Add Widget'
      iconName: 'add'
      onClick: @addNewWidget
      className: 'pt-large pt-fill'
      intent: Intent.SUCCESS
      disabled: !dashboard.isEditing


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

class TitleEditor extends React.Component
  onTitleChange: (value) => @props.dashboard.setProp('title', value)
  render: ->
    {dashboard} = @props
    div className: 'row between middle', =>
      text 'Title'
      crel Title, dashboard: dashboard, onChange: @onTitleChange


class LeftPanelEditing extends React.Component
  stopEditing: =>   @props.dashboard.stopEditing()
  saveDashboard: => @props.editor.saveDashboard()
  discardChanges: =>
    @props.dashboard.setLayout()
    @props.editor.showDiscardDashboardChangesDialog()
  render: ->
    {editor, dashboard} = @props
    div =>
      div className: 'dashboard-editor-buttons', =>
        crel SaveDashboardButton, onClick: @saveDashboard, dashboard: dashboard
        crel DoneEditButton, onClick: @stopEditing, dashboard: dashboard
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
    @props.editor.showConfirmDashboardDeleteDialog()
  closeEditor: =>
    @props.dashboard.close()
    @props.viewStore.showSetupPage()

  render: ->
    {dashboard} = @props
    div =>
      crel ExitEditorButton, onClick: @closeEditor, dashboard: dashboard
      br()
      br()
      div className: 'title-row-container', =>
        div className: 'title-edit middle between', =>
          h3 'Editor'
          crel EditButton, onClick: @startEditing
        div =>
          crel DeleteDashboardButton, onClick: @deleteDashboard
      br()




LeftPanel = observer((props) ->
  {editor, dashboard} = props
  div className: 'pt-dark left-panel', =>
    switch dashboard.isEditing
      when yes then crel LeftPanelEditing, props
      else crel LeftPanelNotEditing, props
    div className: 'title-editor', ->
      div className: 'content', ->
        crel TitleEditor, dashboard: dashboard
    div className: 'dashboard-editor', =>
      crel DashboardProps, dashboard: dashboard
      crel BaseWidgetProperties, dashboard: dashboard
      br()
      br()
      crel AddNewWidgetButton, dashboard: dashboard, editor: editor
)




module.exports = inject('viewStore', 'editor', 'dashboard')(observer(LeftPanel))












