t = require '../LeftPanel/buttons/types'
{extendObservable, action, autorun} = require 'mobx'
buttons = require '../LeftPanel/buttons/buttons'
Button = require './buttonStore'
{clone} = require '../../stores/helpers'

class ViewStore
  constructor: ({@modal, @editor, @store}) ->
    @dashboards = @store.dashboards
    @buttons =
      editor: {}
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
        @editor.create(@newDashboardTitle, @newDashboardDeviceType)
        @closeCreateDashboardPanel()
        @currentPageView = 'EditorPage'
        @newDashboardTitle = ''
        @newDashboardDeviceType = 'tablet'
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

      handleButtonPress: action((e) =>
        switch e.currentTarget.id
          when t.EDIT_DASHBOARD
            @editor.startEditing()
            break
          when t.DONE_EDITING
            @editor.stopEditing()
            break
          when t.EXIT_EDITOR
            @closeAndShowSetupPage()
            break
          when t.ADD_NEW_WIDGET
            @modal.showAddNewWidgetDialog()
            break
          else @editor.handleButtonPress(e.currentTarget.id)
      )





    }

    @editor.buttons[key] = new Button(value, @handleButtonPress) for key, value of buttons






module.exports = ViewStore