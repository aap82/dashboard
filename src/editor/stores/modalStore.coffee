{extendObservable, action} = require 'mobx'
{crel, div} = require 'teact'
AddNewWidget = require '../components/Dialogs/AddNewWidget'
Modals = -> 
  addWidget: 
    id: 'addWidget'
    title: 'Add Widget'
    icon: 'plus'
  

  editWidget:
    id: 'editWidget'
    title: 'Edit Widget'
    icon: 'edit'
  deleteWidget:
    id: 'editWidget'
    title: 'Edit Widget'
    icon: 'warning-sign'


  confirmDeleteDashboard:
    id: 'deleteDashboard'
    title: 'Confirm Delete'
    icon: 'warning-sign'


  confirmDiscardChangesDashboard:
    id: 'discardDashboardChanges'
    title: 'Confirm Discarding Changes'
    icon: 'warning-sign'



class Modal
  constructor: (@modals) ->
    extendObservable @, {
      isModelOpen: no
      activeModel: ''
      modalTitle: ''
      iconName: ''
    }

    close: action(->
      @isModelOpen = no
    )

    open: action((modal) ->
      @activeModal = modal.id
      @modalTitle = modal.title
      @iconName = modal.icon
      @isModelOpen = yes
    )






class ModalStore
  constructor: (@modal, @modals) ->
    extendObservable @, {
      isModelOpen: no
      activeModel: ''
      modalTitle: ''
      iconName: ''
      closeModal: action(->
        @activeModal = ''
        @modalTitle = ''
        @iconName = ''
        @isModelOpen = no
      )

      showAddNewWidgetDialog: action(->
        @activeModal = 'addWidget'
        @modalTitle = 'Add Widget'
        @iconName = 'plus'
        @isModelOpen = yes
      )

      showEditWidgetDialog: action(->
        @activeModal = 'editWidget'
        @modalTitle = 'Edit Widget'
        @iconName = 'edit'
        @isModelOpen = yes
      )

      showConfirmDashboardDeleteDialog: action(->
        @activeModal = 'deleteDashboard'
        @modalTitle = 'Confirm Delete'
        @iconName = 'warning-sign'
        @isModelOpen = yes
      )

      showDiscardDashboardChangesDialog: action(->
        @activeModal = 'discardDashboardChanges'
        @modalTitle = 'Confirm Discarding Changes'
        @iconName = 'warning-sign'
        @isModelOpen = yes
      )
    }

modalStore = new ModalStore()

module.exports = modalStore
module.exports.getDialog = -> crel AddNewWidget, modal: modalStore
