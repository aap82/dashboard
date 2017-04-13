import {extendObservable, action,computed, runInAction} from 'mobx'
import React from 'react'
import {crel, div, h4, h5, br, text, select, option} from 'teact'
import {inject,observer} from 'mobx-react'
import {Intent, Button, EditableText, Dialog} from '@blueprintjs/core'



class AddOrEditWidgetDialog extends React.Component
  constructor: (@props) ->
    @availableTypes =[]

    extendObservable(@, {

      widget:
        platform: '0'
        type: '0'
        deviceId: '0'
        device: ''
        label: 'Widget Label'
      selectedWidgetType: null
      selectedDevice: null



      changePlatform: action((e) =>
        @widget.platform = e.target.value
        if e.target.value is '0'
          @widget.deviceId = '0'
      )
      changeWidgetType: action((e) =>
        runInAction(=>
          if e.target.value is '0' or @widget.type isnt e.target.value
            @widget.deviceId = '0'
            @selectedWidgetType = null
          @widget.type = e.target.value
          if e.target.value isnt '0'
            for w in @props.widgets.widgetTypes
              if w.id is e.target.value then @selectedWidgetType = w.widget
        )
      )



      changeDeviceId: action((e) =>
        @selectedDevice = @props.widgets.devices[e.target.value]
        @widget.label = @props.widgets.devices[e.target.value].name
        @widget.deviceId = e.target.value

      )
      
      
      
      changeLabel: action((value) => @widget.label = value)
      devices: computed(=>
        (value: "#{key}" for key, value of  @props.widgets.devices when value.type in (@selectedWidgetType?.types or [] ) and value.platform is @widget.platform)
      )
      widgetLabel: computed(=>
        deviceId = @widget.deviceId
        if deviceId  is '0'
          disabled: yes
          label: 'Widget Label' 
        else 
          disabled: no
          label:  @props.widgets.devices[deviceId].name
      )



      addWidget: action(=>
        runInAction(=>
#          widget = widgets.getWidget(@widget, @selectedDevice, @props.editor.widgetProps)
          @props.editor.createWidget(@widget.label, @selectedWidgetType, @selectedDevice)
          @reset()
        )
      )
      reset: action(=>
        @selectedDevice = null
        @widget =
          platform: '0'
          type: '0'
          deviceId: '0'
          label: 'Widget Label'
          props: {}
        @props.close()

      )

    })
  render: ->
    {widgets} = @props
    div className: 'create-widget-dialog', =>
      crel SelectWidgetType, widget: @widget,widgets: widgets, onChange: @changeWidgetType
      br()
      crel SelectPlatform,  widget: @widget, widgets: widgets, onChange: @changePlatform, widgetType: @selectedWidgetType
      br()
      crel SelectDeviceType, widget: @widget, onChange: @changeDeviceId, devices: @devices
      br()
      crel InputWidgetLabel,  widgetLabel: @widgetLabel, onChange: @changeLabel,
      br()
      br()
      div className: 'pt-dialog-footer', =>
        div className: "pt-dialog-footer-actions around", =>
          crel AddselectedDeviceButton, widget: @widget, onClick: @addWidget
          crel Button,
            text: 'CANCEL'
            intent: Intent.DANGER
            className: 'pt-large'
            onClick: @reset

AddOrEditWidgetDialog = inject('editor', 'widgets')(observer(AddOrEditWidgetDialog))
export default AddOrEditWidgetDialog

AddselectedDeviceButton = observer(({widget, onClick}) ->
  crel Button,
    text: 'Add Widget'
    iconName: 'add'
    onClick: onClick
    className: 'pt-large'
    intent: Intent.SUCCESS
    disabled: !(widget.platform isnt '0' and widget.type isnt '0' and widget.deviceId isnt '0')
)

SelectPlatform = observer(({widget, widgets, onChange, widgetType}) ->
  disabled = (widgetType is null)
  div className: ' row between middle', ->
    text 'Widget Device Platform:'
    div className: 'pt-select ', ->
      select value: widget.platform, onChange: onChange, disabled: disabled, ->
        option value: '0', 'Select Platform'
        widgets.platforms.map((platform) ->
          option value: platform, "#{platform}"
        )
)



SelectWidgetType = observer(({widget, widgets, onChange}) ->
  div className: 'row between middle', ->
    text 'Widget Type:'
    div className: 'pt-select ', ->
      select value: widget.type, onChange: onChange, ->
        option value: '0', 'Select Type'
        widgets.widgetTypes.map((widget) ->
          option value: widget.id, "#{widget.name}"
        )
)





SelectDeviceType = observer(({widget, onChange, devices}) ->
  disabled = (devices.length is 0)
  className = 'pt-select' + if disabled then ' pt-disabled' else ''
  div className: 'row between middle', =>
    text 'Widget Device Id:'
    div className: className, =>
      select disabled: disabled, value: widget.deviceId, onChange: onChange, ->
        option className: 'pt-rtl', value: '0', 'Select Device'
        switch
          when null
          else
            option value: device.value, "#{device.value}" for device in devices
)



InputWidgetLabel = observer(({onChange, widgetLabel}) ->
  div className: 'row between middle', =>
    text 'Widget Label:'
    h5 =>
      crel EditableText,
        defaultValue: widgetLabel.label
        selectAllOnFocus: yes
        disabled: widgetLabel.disabled
        onChange: onChange
        className: 'widget-label-editor ' + widgetLabel.disabled

)

