import mobx, {extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import uuidV4 from 'uuid/v4'


export class GridSettings
  constructor: (type, @deviceHeight, @deviceWidth, props = {}) ->
    extendObservable @, {
      backgroundColor: observable.object({
        color: if props.background? then props.background.color else "#182026"
        alpha: 100
      })
      orientation: props.orientation or if type is 'phone' then 'landscape' else 'landscape'
      cols: props.cols or @deviceWidth
      rowHeight: props.rowHeight or 1
      marginX: props.marginX or 0
      marginY: props.marginY or 0
      width: computed(->
        switch @orientation
          when 'landscape' then @deviceHeight
          else @deviceWidth
      )
      height: computed(->
        switch @orientation
          when 'landscape' then @deviceWidth
          else @deviceHeight
      )
      maxRows: computed(-> @height / @rowHeight )


      deserialize: action((props) ->
        @backgroundColor =
          color: props.backgroundColor.color
          alpha: props.backgroundColor.alpha
        @orientation = props.orientation
        @cols = props.cols
        @rowHeight = props.rowHeight
        @marginX = props.marginX
        @marginY = props.marginY
      )      
      
    }
  serialize: ->
      backgroundColor: toJS(@backgroundColor)
      orientation: @orientation
      cols: @cols
      rowHeight: @rowHeight
      marginX: @marginX
      marginY: @marginY
      width: @width
      height: @height
      maxRows: @maxRows


export class WidgetColor
  constructor: (props = {}) ->
    extendObservable @, {
      backgroundColor: observable.object({
        color: if props.background? then props.background.color else "#182026"
        alpha: 100
      })      
      
      
    }
  serialize: ->    backgroundColor: toJS(@backgroundColor)


export class WidgetFontStyles
  constructor: (props = {}) ->
    extendObservable @, {
      primaryColor: props.primaryColor or '#ffffff'
      primaryFontSize: props.primaryFontSize or 18
      primaryFontWeight: props.primaryFontWeight or 600
      secondaryColor: props.secondaryColor or '#ffffff'
      secondaryFontSize: props.secondaryFontSize or 14
      secondaryFontWeight: props.secondaryFontWeight or 400

      deserialize: action((props) ->
        @primaryColor = props.primaryColor
        @primaryFontSize = props.primaryFontSize
        @primaryFontWeight = props.primaryFontWeight
        @secondaryColor = props.secondaryColor
        @secondaryFontSize = props.secondaryFontSize
        @secondaryFontWeight = props.secondaryFontWeight
      )
    }

  serialize: ->
    primaryColor: @primaryColor
    primaryFontSize: @primaryFontSize
    primaryFontWeight: @primaryFontWeight
    secondaryColor: @secondaryColor
    secondaryFontSize: @secondaryFontSize
    secondaryFontWeight: @secondaryFontWeight

