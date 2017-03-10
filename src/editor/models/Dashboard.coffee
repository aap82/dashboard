{setDefaultModelSchema, identifier, object, deserialize, list} = require 'serializr'
{extendObservable, computed, toJS, computed, runInAction} = require 'mobx'
ObservableClass = require '../../models/Observable'
{dashboardSchema, layoutSchema, Dashboard} = require '../../models/Dashboard'
{colorPickers, colorPickerSchema, ColorPickerModel} = require './ColorPickers'
{widgetPropsSchema, defaultWidgetProps} = require './WidgetProps'
{widgetEditorSchema, WidgetEditorModel} = require '../models/Widget'


dashboardBackground = deserialize(colorPickerSchema, {
  id: 'dashboardBackground'
  target: 'backgroundColor'
  text: 'Background Color'
  color: '#5c5b58'
  alpha: 100
})

class DashboardEditorModel
  constructor: (args) ->
    @background = args.background
    extendObservable @, {
      backgroundColor: '#fff'

      title: ''
      deviceType: ''
      width: 0
      widgetProps: args.widgetProps
      widgets: []
      layouts: []
      style: computed(=>
        position: 'relative'
        height: '100%'
        width:  @width
        backgroundColor: @background.color
        color: "#fff"
      )
      backgroundColor: computed(=>  @background.color)
      widgetBorderRadius: 2
      widgetCardDepth: 2
      widgetBackgroundColor: computed(=> @widgetProps.background.color)
      widgetBackgroundAlpha: computed(=> @widgetProps.background.alpha)
      widgetFontColor: computed(=> @widgetProps.fontColor.color)


    }





export dashboardEditorSchema =
  factory: ((context) -> return new DashboardEditorModel(context.args))
  props:
#    props:
    id: identifier()
    uuid: identifier()
    cols: yes
    marginX: yes
    marginY: yes
    rowHeight: yes
    title: yes
    deviceType: yes
    width: yes

    widgets: list(object(widgetEditorSchema))
    background: object(ColorPickerModel)
    widgetProps: object(widgetPropsSchema)
    layouts: list(object(layoutSchema))

    


setDefaultModelSchema(DashboardEditorModel, dashboardEditorSchema)

export DashboardEditor = deserialize(dashboardEditorSchema, {
    id: -1
    title: 'Dashboard Editor'
    deviceType: 'Tablet'
    cols: 155
    marginX: 0
    marginY: 0
    rowHeight: 5
    widgets: []
    layouts: []
    devices: []
    width: 1200
    
    
  },
  (-> return),
  {
    background: dashboardBackground
    widgetProps: defaultWidgetProps
  }
)
