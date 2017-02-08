{extendObservable, action, toJS} = require 'mobx'
class ViewStore
  constructor: ({@modal, @editor, @store}) ->
    console.log @store
    @dashboards = @store.dashboards
    extendObservable @, {

      selectedDashboardId: 0
      setSelectedDashboard: action((id) -> @selectedDashboardId = id)

      currentPageView: 'SetupPage'
      showEditorPage: action(-> @currentPageView = 'EditorPage')
      showSetupPage: action(-> @currentPageView = 'SetupPage')


      isCreateNewDashboardPanelOpen: no
      openCreateDashboardPanel: action(-> @isCreateNewDashboardPanelOpen = yes      )
      closeCreateDashboardPanel: action( ->@isCreateNewDashboardPanelOpen = no      )

      newDashboardTitle: ''
      changeNewDashboardTitle: action((value) -> @newDashboardTitle = value)

      newDashboardDeviceType: 'tablet'
      changeNewDashboardDeviceType: action((type) -> @newDashboardDeviceType = type)

      createNewDashboard: action( ->
        dashboard = @editor.create(@newDashboardTitle, @newDashboardDeviceType)
        @closeCreateDashboardPanel()
        @showEditorPage()
        @newDashboardTitle = ''
        @newDashboardDeviceType = 'tablet'
        @store.add dashboard
      )

      handleDeletedDashboard: action( ->
        @selectedDashboardId = '0'
        @currentPageView = 'SetupPage'
      )

      loadAndShowDashboard: action(->
        @store.loadDashboard(@selectedDashboardId)
      )
      closeAndShowSetupPage: action(->
        @editor.close()
        @showSetupPage()

      )


    }





module.exports = ViewStore