{extendObservable, action} = require 'mobx'

class ModalStore
  constructor:  ->
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