import {extendObservable, observable, computed, runInAction, action} from 'mobx'
import Color from 'color'

class WidgetStyle
  constructor: ->
    extendObservable @, {
      borderRadius: 2
      cardDepth: 2
      backgroundColor: '#be682e'
      backgroundAlpha: 100
      fontColor: '#fff'
      fontSizePrimary: 18
      fontSizeSecondary: 12
      fontWeightPrimary: 600
      fontWeightSecondary: 400

      style: computed(->
        backgroundColor: Color(@backgroundColor.alpha(@backgroundAlpha/100).hsl().string())
        fontColor: @fontColor
        borderRadius: @borderRadius

      )
    }


export default WidgetStyle