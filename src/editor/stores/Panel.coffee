import {extendObservable, observable, computed, runInAction, action} from 'mobx'

class Panel
  constructor: ->
    @component = null
    extendObservable @, {
      openPanel: action( -> @isOpen = yes)
      closePanel: action(-> @isOpen = no)
      togglePanel: action(->@isOpen = !@isOpen)

      width: 250
      height: 425
      setPanelSize: action((size) ->
        runInAction(=>
          @width = size.width
          @height = size.height

        )

      )

      enableDrag: action(->@component.updateDraggability(yes))
      disableDrag: action(->@component.updateDraggability(no))

      initial: observable.object({
        x: 500
        y: 25
        width: 250
        height: 425
      })

      minWidth: 250
      minHeight: 425
      maxWidth: 800
      maxHeight: 800


    }


panel = new Panel

export default panel