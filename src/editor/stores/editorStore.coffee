{extendObservable, action, computed, asMap, toJS} = require 'mobx'

DashboardStore = require './dashboardStore'
DashboardEditor = require './dashboardEditor'
WidgetEditor = require './widgetEditor'



class Editor
  constructor:  ->
    @fetch = null
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
        WidgetEditor.resetAddWidgetDialog()
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


      loadDashboard: action((id) =>
        @selectedDashboardId = id
        dashboard = DashboardStore.getDashboardById(id)
        DashboardEditor.load(dashboard)
      )

      saveDashboard: action(->
        props = DashboardEditor.toJSON()
        console.log props
        id = DashboardEditor.dashboardId
        switch
          when id < 500 then @fetch('opName', 'UpdateDashboard', {id: id, dashboard: props}).then(@updateDashboardFromResponse)
          else @fetch('opName', 'CreateDashboard', dashboard: props).then(@addDashboardFromResponse)
      )

      discardDashboardChanges: action(->
        id = DashboardEditor.dashboardId
        dashboard = DashboardStore.getDashboardById(id)
        DashboardEditor.load(dashboard)
      )
      addDashboardFromResponse: action((response) ->
        data = response.data.create
        DashboardEditor.dashboardId = data.id
        DashboardStore.createDashboard(data)
      )

      updateDashboardFromResponse: action((response) ->
        data = response.data.update
        DashboardStore.updateDashboard(data.id, data)
      )

      deleteDashboard: action(->
        id = DashboardEditor.dashboardId
        @fetch('opName', 'DeleteDashboard', {id: id}).then(@deleteDashboardResponse)
      )

      deleteDashboardResponse: action((response) ->
        if response.errors
          return
        else
          DashboardStore.deleteDashboard(response.data.delete.id)
          console.log 'no errors'
          return
      )





    }




editor = new Editor()



module.exports =  editor