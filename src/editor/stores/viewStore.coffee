remotedev = require('mobx-remotedev')
{extendObservable, action, toJS} = require 'mobx'
DashboardEditor = require './dashboardEditor'

class ViewStore
  constructor: ->
    extendObservable @, {
      dashboards: []
      userDashboards: []
      setUserDashboards: action((dashboards) -> @userDashboards.replace(dashboards))

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
        DashboardEditor.create(@newDashboardTitle, @newDashboardDeviceType)
        @closeCreateDashboardPanel()
        @showEditorPage()
        @newDashboardTitle = ''
        @newDashboardDeviceType = 'tablet'
      )

      handleDeletedDashboard: action( ->
        @selectedDashboardId = '0'
        @currentPageView = 'SetupPage'

      )


    }



viewStore = new ViewStore()

module.exports = remotedev(viewStore)