import {extendObservable, action, runInAction, computed} from 'mobx'
import {crel, div} from 'teact'
import CreateNewDashboard from '../components/CreateNewDashboard'
import AddNewWidget from '../components/Dialogs/AddNewWidget'
import ConfirmDashboardDelete from '../components/Dialogs/ConfirmDashboardDelete'
import DiscardDashboardChanges from '../components/Dialogs/DiscardDashboardChanges'
import EditWidget from '../components/Dialogs/EditWidget'

Modals = -> 
  addWidget: 
    id: 'addWidget'
    title: 'Add Widget'
    icon: 'plus'
    forceClose: yes

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

  addDashboard:
    id: 'addDashboard'
    title: 'Add New Dashboard'
    icon: 'plus'
    style:
      width: 400

class ModalStore
  constructor: (@modals) ->
    extendObservable @, {
      id: ''
      isOpen: no
      title: ''
      iconName: ''
      style: {}
      open: action((id) =>
        modal = @modals[id]
        runInAction(=>
          @id = modal.id
          @title = modal.title
          @iconName = modal.icon
          @isOpen = yes
          @style = modal.style ?= {}
        )
      )

      close: action(=>
        @id = ''
        @isOpen = no
      )

      component: computed(->
        switch @id
          when 'addDashboard' then return crel CreateNewDashboard, close: @close
          when 'addWidget' then return crel AddNewWidget, close: @close
          when 'editWidget' then return crel EditWidget, close: @close
          when 'deleteDashboard' then return crel ConfirmDashboardDelete, close: @close
          when 'discardDashboardChanges' then return crel DiscardDashboardChanges, close: @close
          else return null
      )

    }



modalStore = new ModalStore(new Modals)

export default modalStore
