{extendObservable, action, computed, asMap, toJS} = require 'mobx'

DashboardView = require './DashboardView'
DashboardStore = require './dashboardStore'
DashboardEditor = require './dashboardEditor'
WidgetEditor = require './widgetEditor'



class EditorView
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
        console.log dashboard
        DashboardEditor.load(dashboard)
      )
      close: action(->
        DashboardEditor.close()
      )

      saveDashboard: action(=>
        DashboardView.setProp('layouts', DashboardEditor.newLayout)
        props = toJS(DashboardEditor.toJSON())
        console.log props
        id = props.id
        delete props['id']
        console.log props


        switch
          when id < 500 then @fetch('opName', 'UpdateDashboard', {id: id, dashboard: props}).then(@updateDashboardFromResponse)
          else @fetch('opName', 'CreateDashboard', dashboard: props).then(@addDashboardFromResponse)
      )


      addDashboardFromResponse: action((response) =>
        if response.errors
          console.log response.errors
          return
        else
          console.log response
          data = response.data.create
          DashboardView.id = data.id
          DashboardStore.createDashboard(data)
      )

      updateDashboardFromResponse: action((response) =>
        if response.errors
          console.log response.errors
          return
        else
          console.log response
          data = response.data.update
          DashboardStore.updateDashboard(data.id, data)

      )

      deleteDashboard: action(->
        console.log DashboardView.id
        id = DashboardView.id
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

      discardDashboardChanges: action(->
        dashboard = DashboardStore.getDashboardById(DashboardView.id)
        DashboardEditor.load(dashboard)
      )



    }



editor = new EditorView()



module.exports =  editor