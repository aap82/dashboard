{crel, div} = require 'teact'
{observer} = require 'mobx-react'
{Dialog} = require('@blueprintjs/core')
AddNewWidget = require './Dialogs/AddNewWidget'
EditWidget = require './Dialogs/EditWidget'
ConfirmDashboardDelete = require './Dialogs/ConfirmDashboardDelete'
DiscardDashboardChanges = require './Dialogs/DiscardDashboardChanges'

DialogComponentContainer = observer(({editor}) =>
  crel Dialog,
    className: 'pt-dark'
    isCloseButtonShown: no
    canEscapeKeyClose: yes
    canOutsideClickClose: no
    transitionDuration: 200
    title: editor.modalTitle
    iconName: editor.iconName
    isOpen: editor.isModelOpen, =>
      div 'pt-dialog-body', ->
        switch editor.activeModal
          when 'addWidget' then return crel AddNewWidget, editor: editor
          when 'editWidget' then return crel EditWidget, editor: editor
          when 'deleteDashboard' then return crel ConfirmDashboardDelete, editor: editor
          when 'discardDashboardChanges' then return crel DiscardDashboardChanges, editor: editor
          else return null

)

module.exports = DialogComponentContainer

