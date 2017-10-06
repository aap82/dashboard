import {extendObservable, observable, computed, runInAction, action} from 'mobx'

app_panels =
  settings:
    id: 'settings'
    isShowing: yes
    tab: 'grid'
    openPicker: null
    style:
      backgroundColor:  "rgba(0, 2, 0, 1)"
      borderColor: 'silver'
      borderWidth: 1
      borderStyle: 'solid'
    initial:
      x: 100
      y: 500
      width: 255
      height: 355
    minWidth: 255
    minHeight: 355
    maxWidth: 400
    maxHeight: 360




class PanelStore
  constructor: (panels) ->
    @component = null
    @components = {}
    extendObservable @, {
      openPanels: []
      activePanel: null
      panels: panels
      openPanel: action((id)  ->
        @openPanels.push id
        @panels[id].isShowing = yes
      )

      closePanel: action((id) ->
        @openPanels.remove id
        @panels[id].isShowing= no
      )
      togglePanel: action((id) ->
        if @panels[id].isShowing
          @closePanel(id)
        else
          @openPanel(id)
      )
      enableDrag: action((id) -> @components[id].updateDraggability(yes))
      disableDrag: action((id) ->
        @activePanel = id
        @components[id].updateDraggability(no)
      )
      openOnlyPanel: action((id)  ->
        runInAction(=>
          @panels[key].isShowing = no for key, panel of @panels when key isnt id
          @panels[id].isShowing = yes
        )
      )
    }

  setComponent: (id, component) => @components[id] = component


#  handleKeyDownWhenPanelOpen: (e) => @closeSettingsColorPicker() if e.keyCode is 27


panel = new PanelStore(app_panels)

export default panel

#
#isSettingsColorPickerPanelOpen: no
#openSettingsColorPicker: action(->
#  runInAction(=>
#    document.addEventListener('keydown', @handleColorPickerKeyDown)
#    @isSettingsColorPickerPanelOpen = yes
#  )
#)
#closeSettingsColorPicker: action(->
#  runInAction(=>
#    document.removeEventListener('keydown', @handleColorPickerKeyDown)
#    @isSettingsColorPickerPanelOpen = no
#  )
#)
#toggleSettingsColorPickerPanel: action(->
#
#  if @isSettingsColorPickerPanelOpen then @closeSettingsColorPicker() else @openSettingsColorPicker())
