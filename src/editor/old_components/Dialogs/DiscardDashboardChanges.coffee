import React from 'react'
import {crel, div, h4, h5, br, text, select, option} from 'teact'
import {inject,observer} from 'mobx-react'
import {Intent, Button, EditableText} from '@blueprintjs/core'


DiscardDashboardChanges = ({onClick}) ->
  crel Button,
    text: 'Discard'
    iconName: 'cross'
    onClick: onClick
    className: 'pt-large pt-fill'
    intent: Intent.DANGER

CancelDiscardChanges = ({onClick}) ->
  crel Button,
    text: 'Cancel'
    onClick: onClick
    className: 'pt-large pt-fill'


class DiscardDashboardChangesDialog extends React.Component
  discardDashboardChanges: =>
#    @props.editor.discardDashboardChanges()
    @props.modal.closeModal()
  cancelDiscardDashboard: =>  @props.modal.closeModal()

  render: ->
    div className: 'create-widget-dialog', =>
      crel 'div', style: fontSize: 20, marginBottom: 30, "Are you sure you want to discard changes made to this Dashboard?  This can not be undone."
      div className: 'pt-dialog-footer', =>
        div className: "pt-dialog-footer-actions", =>
          crel DiscardDashboardChanges, onClick: @discardDashboardChanges
          crel CancelDiscardChanges, onClick: @cancelDiscardDashboard



export default DiscardDashboardChangesDialog

