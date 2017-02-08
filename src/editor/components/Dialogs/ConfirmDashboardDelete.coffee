React = require 'react'
{crel, div} = require 'teact'
{Intent, Button} = require('@blueprintjs/core')


DeleteDashboard = ({onClick}) ->
  crel Button,
    text: 'Delete'
    iconName: 'delete'
    onClick: onClick
    className: 'pt-large pt-fill'
    intent: Intent.DANGER

CancelDeleteDashboard = ({onClick}) ->
  crel Button,
    text: 'Cancel'
    onClick: onClick
    className: 'pt-large pt-fill'


class ConfirmDashboardDeleteDialog extends React.Component
  deleteDashboard: =>
    @props.viewStore.deleteDashboard()
  cancelDeleteDashboard: =>  @props.editorView.closeModal()

  render: ->
    div className: 'create-widget-dialog', =>
      crel 'div', style: fontSize: 20, marginBottom: 30, "Are you sure you want to delete this Dashboard?"
      div className: 'pt-dialog-footer', =>
        div className: "pt-dialog-footer-actions", =>
          crel DeleteDashboard, onClick: @deleteDashboard
          crel CancelDeleteDashboard, onClick: @cancelDeleteDashboard



module.exports = ConfirmDashboardDeleteDialog

