{extendObservable, action, toJS, computed, runInAction} = require 'mobx'
t = require '../LeftPanel/buttons/types'
buttons = require '../LeftPanel/buttons/buttons'
Button = require './buttonStore'
class EditableDashboard
  class Memento
    constructor: (@dashboard, @widgetProps) ->

  class Dashboard
    constructor: (dashboard) ->
      @id = dashboard.id
      @cols =  dashboard.cols
      @marginX =  dashboard.marginX
      @marginY  =  dashboard.marginY
      @rowHeight = dashboard.rowHeight
      @devices = dashboard.devices
      extendObservable(@, {
        title:  dashboard.title
        deviceType:  dashboard.deviceType
        widgets:  dashboard.widgets
        layouts:  dashboard.layouts
        width:  dashboard.width
        backgroundColor: dashboard.backgroundColor
        color: dashboard.color
      })

  class WidgetProps
    constructor: (widgetProps) ->
      extendObservable(@, {
        backgroundColor: "#ff525b"
        backgroundAlpha: 100
        color: "#fff"
        borderRadius: 2
        cardDepth: 2
      })

  constructor: ->
    @dashboard = null
    @widgetProps = null
    @memento = null


  init: (dashboard) ->
    {widgetProps} = dashboard
    @widgetProps = new WidgetProps(widgetProps)
    @dashboard = new Dashboard(dashboard)
    @memento = new Memento toJS(@dashboard), toJS(@widgetProps)
    return

  save: ->
    @memento = new Memento toJS(@dashboard), toJS(@widgetProps)
    return





class EditorView extends EditableDashboard
  constructor: ->
    @buttons = {}
    super
    extendObservable @, {
      isEditing: no
      isDirty: computed(-> !(JSON.stringify(toJS(@dashboard)) is JSON.stringify(@memento.dashboard)))
      load: action((dashboard) -> @init(dashboard))
      startEditing: action(-> @isEditing = yes)
      stopEditing: action(-> @isEditing = no)
      restore: action(=>
        runInAction(=>
          @dashboard[key] = value for key, value of toJS(@memento.dashboard) when @dashboard[key] isnt value
          @widgetProps[key] = value for key, value of toJS(@memento.widgetProps) when @widgetProps[key] isnt value

        )


      )








      handleWidgetPropChange: action((id) ->
        switch id
          when t.INC_CARD_DEPTH
            break if @widgetProps.cardDepth is 5
            value = @widgetProps.cardDepth
            value++
            @widgetProps.cardDepth = value
            break
          when t.DEC_CARD_DEPTH
            break if @widgetProps.cardDepth is 0
            value = @widgetProps.cardDepth
            value--
            @widgetProps.cardDepth = value
            break
          when t.INC_BORDER_RADIUS
            value = @widgetProps.borderRadius
            value++
            @widgetProps.borderRadius = value
            break
          when t.DEC_BORDER_RADIUS
            break if @widgetProps.borderRadius is 0
            value = @widgetProps.borderRadius
            value--
            @widgetProps.borderRadius = value
            break


      )

    }

    @buttons[key] = new Button(@, value) for key, value of buttons








editorView = new EditorView

module.exports = editorView
