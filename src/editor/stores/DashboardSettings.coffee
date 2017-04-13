import mobx, {extras, extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import uuidV4 from 'uuid/v4'


export class Settings
  constructor: ->
    extendObservable @, {
      backup: null
      isDirty: computed(-> !extras.deepEqual(@backup, @serialize()))
    }

  serialize: ->
  save: ->
    @backup = mobx.toJS(@serialize())
    return @backup
  restore: ->
    @deserialize(mobx.toJS(@backup))
    return @backup





export class GridSettings extends Settings
  constructor: (type, @deviceHeight, @deviceWidth, props = {}) ->
    super()
    extendObservable @, {
      backgroundColor: props.backgroundColor or "#182026"
      orientation: props.orientation or if type is 'phone' then 'landscape' else 'landscape'


      columns: props.columns or 1
      colUnit: props.colUnit or 'pixel_width'
      changeUnit: action((unit) ->
        runInAction(=>
          if unit is 'pixel_width'
            @columns = Math.floor(@colWidth)
          else
            @columns = Math.floor(@cols)
          @colUnit = unit
        )

      )

      cols: computed(->
        if @colUnit is 'pixel_width'
          @width / @columns
        else
          @columns
      )

      colWidth: computed(->
        if @colUnit is 'pixel_width'
          @cols / @width
        else
          @width / @cols
      )



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
        @backgroundColor = props.backgroundColor
        @orientation = props.orientation
        @rowHeight = props.rowHeight
        @marginX = props.marginX
        @marginY = props.marginY
        @columns = props.columns
        @colUnit = props.colUnit
      )

    }
    @save()

  serialize: ->
      backgroundColor: @backgroundColor
      orientation: @orientation
      columns: @columns
      colUnit: @colUnit
      cols: @cols
      rowHeight: @rowHeight
      marginX: @marginX
      marginY: @marginY
      width: @width
      height: @height
      maxRows: @maxRows


export class WidgetStyleSettings  extends Settings
  constructor: (props = {}) ->
    extendObservable @, {
      backgroundColor: props.backgroundColor or "#182026"
      deserialize: action((props) ->
        @backgroundColor = props.backgroundColor
      )
    }
    @save()
  serialize: ->    widgetBackgroundColor: @backgroundColor


export class WidgetFontSettings  extends Settings
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
    @save()

  serialize: ->
    primaryColor: @primaryColor
    primaryFontSize: @primaryFontSize
    primaryFontWeight: @primaryFontWeight
    secondaryColor: @secondaryColor
    secondaryFontSize: @secondaryFontSize
    secondaryFontWeight: @secondaryFontWeight

