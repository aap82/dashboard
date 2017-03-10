{extendObservable, action} = require 'mobx'
t = require '../LeftPanel/buttons/types'
{extendObservable, action, autorun} = require 'mobx'



class ViewState
  constructor: ({@modal, @editor, @store}) ->
    extendObservable @, {
      dashboards: []
      selectedDashboardId: 0
      visiblePage: 'setup'
      setViewPageTo: action((view) -> if view in ['setup', 'editor'] then @visiblePage = view else return)
      showEditorPage: action(-> @visiblePage = 'editor')
      showSetupPage: action(-> @visiblePage = 'setup')




    }
    @editor.exit = => @showSetupPage()



module.exports = ViewState



