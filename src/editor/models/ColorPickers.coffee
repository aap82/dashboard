{setDefaultModelSchema, createSimpleSchema, object, identifier, deserialize} = require 'serializr'
{extendObservable, computed, toJS, computed, runInAction} = require 'mobx'
{Dashboard} = require '../../models/Dashboard'
ObservableClass = require '../../models/Observable'
Color = require 'color'

export pickers = {}

widgetBackground =
  id: 'widgetBackground'
  target: 'backgroundColor'
  text: 'Background Color'
  color: '#130C3B'
  alpha: 100
widgetFont =
  id: 'widgetFont'
  target: 'fontColor'
  text: 'Background Color'
  color: '#ffffff'
  alpha: 100

export class ColorPickerModel
  constructor: (color, alpha=100) ->
    extendObservable @, {
      color: color
      alpha: alpha
      hsv: {h: 0, s: 0, v: 0}
    }
    super(@)


export colorPickerSchema =
  factory: ((context) ->
    id = context.json.id
    if !pickers[id]?
      pickers[id] = new ColorPickerModel
    pickers[id]
  )
  props:
    id: identifier()
    text: yes
    color: yes
    alpha: yes
    


setDefaultModelSchema(ColorPickerModel, colorPickerSchema)


widgetBackground = deserialize(colorPickerSchema, widgetBackground)
widgetFont = deserialize(colorPickerSchema, widgetFont)


export colorPickers =
  widgetBackground: widgetBackground
  widgetFont: widgetFont
