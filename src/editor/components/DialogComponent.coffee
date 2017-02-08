{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'
{Dialog} = require('@blueprintjs/core')
AddNewWidget = require './Dialogs/AddNewWidget'
EditWidget = require './Dialogs/EditWidget'
ConfirmDashboardDelete = require './Dialogs/ConfirmDashboardDelete'
DiscardDashboardChanges = require './Dialogs/DiscardDashboardChanges'

DialogComponentContainer = observer(({modal}) =>
  crel Dialog,
    className: 'pt-dark'
    isCloseButtonShown: no
    canEscapeKeyClose: yes
    canOutsideClickClose: no
    transitionDuration: 200
    title: modal.modalTitle
    iconName: modal.iconName
    isOpen: modal.isModelOpen, =>
      div 'pt-dialog-body', ->
        switch modal.activeModal
          when 'addWidget' then return crel AddNewWidget, modal: modal
          when 'editWidget' then return crel EditWidget, modal: modal
          when 'deleteDashboard' then return crel ConfirmDashboardDelete, modal: modal
          when 'discardDashboardChanges' then return crel DiscardDashboardChanges, modal: modal
          else return null

)

module.exports = inject('modal')(DialogComponentContainer)

