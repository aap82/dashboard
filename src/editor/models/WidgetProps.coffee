{setDefaultModelSchema, object} = require 'serializr'
{extendObservable, computed, computed} = require 'mobx'
{colorPickers, ColorPickerModel} = require './ColorPickers'
Color = require 'color'


export class DefaultWidgetProps
  constructor: (background, fontColor) ->
    @background = background
    @fontColor = fontColor
    extendObservable @, {
      style: computed(=>
        backgroundColor: Color(@background.color).alpha(@background.alpha/100).hsl().string()
        color: @fontColor.color
        borderRadius: @borderRadius
      )
      borderRadius: 2
      cardDepth: 2
    }

export defaultWidgetProps = new DefaultWidgetProps(colorPickers.widgetBackground, colorPickers.widgetFont)
export widgetPropsSchema =
  factory: (-> return defaultWidgetProps)
  props:
    background: object(ColorPickerModel)
    fontColor: object(ColorPickerModel)
    borderRadius: yes
    cardDepth: yes

setDefaultModelSchema(DefaultWidgetProps, widgetPropsSchema)




