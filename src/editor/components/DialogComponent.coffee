{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'
{Dialog} = require('@blueprintjs/core')
AddNewWidget = require './Dialogs/AddNewWidget'
EditWidget = require './Dialogs/EditWidget'
ConfirmDashboardDelete = require './Dialogs/ConfirmDashboardDelete'
DiscardDashboardChanges = require './Dialogs/DiscardDashboardChanges'

DialogComponentContainer = observer(({editorView}) =>
  crel Dialog,
    className: 'pt-dark'
    isCloseButtonShown: no
    canEscapeKeyClose: yes
    canOutsideClickClose: no
    transitionDuration: 200
    title: editorView.modalTitle
    iconName: editorView.iconName
    isOpen: editorView.isModelOpen, =>
      div 'pt-dialog-body', ->
        switch editorView.activeModal
          when 'addWidget' then return crel AddNewWidget, editorView: editorView
          when 'editWidget' then return crel EditWidget, editorView: editorView
          when 'deleteDashboard' then return crel ConfirmDashboardDelete, editorView: editorView
          when 'discardDashboardChanges' then return crel DiscardDashboardChanges, editorView: editorView
          else return null

)

module.exports = inject('editorView')(DialogComponentContainer)

