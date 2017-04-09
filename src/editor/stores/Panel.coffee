import {extendObservable, observable, computed, runInAction, action} from 'mobx'

class Panel
  constructor: ->
    @component = null
    extendObservable @, {
      isOpen: no
      openPanel: action( -> @isOpen = yes)
      closePanel: action(-> @isOpen = no)
      togglePanel: action(->@isOpen = !@isOpen)



      initial: observable.object({
        x: 500
        y: 25
        width: 200
        height: 400
      })

      minWidth: 200
      maxWidth: 225
      minHeight: 160
      maxWidth: 800
      maxHeight: 800
      moveAxis: 'both'


    }


panel = new Panel

export default panel