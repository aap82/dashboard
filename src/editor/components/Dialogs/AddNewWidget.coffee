React = require 'react'
{crel, div, h4, h5, br, text, select, option} = require 'teact'
{inject,observer} = require 'mobx-react'
{Intent, Button, EditableText, Dialog} = require('@blueprintjs/core')

AddNewWidgetButton = observer(({widgetEditor, onClick}) ->
  crel Button,
    text: 'Add Widget'
    iconName: 'add'
    onClick: onClick
    className: 'pt-large'
    intent: Intent.SUCCESS
    disabled: widgetEditor.addNewWidgetButtonDisabled
)

SelectNewWidgetPlatform = observer(({widgetEditor, onChange}) ->
  div className: ' row between middle', ->
    text 'Widget Device Platform:'
    div className: 'pt-select ', ->
      select value: widgetEditor.selectedDevicePlatform, onChange: onChange, ->
        option value: '0', 'Select Platform'
        widgetEditor.availablePlatforms.map((platform) ->
          option value: platform, "#{platform}"
        )
)



SelectNewWidgetType = observer(({widgetEditor, onChange}) ->

  div className: 'row between middle', ->
    text 'Widget Type:'
    div className: 'pt-select ', ->
      select value: widgetEditor.selectedWidgetType, onChange: onChange, ->
        option value: '0', 'Select Type'
        widgetEditor.widgets.map((widget) ->
          option value: widget, "#{widget}"
        )
)





SelectNewDeviceId = observer(({widgetEditor, onChange}) ->
  disabled = (widgetEditor.selectedWidgetType is '0' or widgetEditor.selectedDevicePlatform is '0')
  className = 'pt-select' + if disabled then ' pt-disabled' else ''
  div className: 'row between middle', =>
    text 'Widget Device Id:'
    div className: className, =>
      select disabled: disabled, value: widgetEditor.selectedDevice, onChange: onChange, ->
        option className: 'pt-rtl', value: '0', 'Select Device'
        widgetEditor.availableDevices.map((device) ->
          option className: 'pt-rtl', value: device.id, "#{device.id}"
        )

)



InputNewWidgetLabel = observer(({widgetEditor, onChange}) ->
  disabled = (widgetEditor.selectedDevice is '0')
  div className: 'row between middle', =>
    text 'Widget Label:'
    h5 =>
      crel EditableText,
        value: if disabled then 'Widget Label' else widgetEditor.newWidgetLabel
        selectAllOnFocus: yes
        disabled: disabled
        onChange: onChange
        className: 'widget-label-editor ' + disabled

)




class AddNewWidgetDialogContent extends React.Component
  onNewWidgetDevicePlatformChange: (e) => @props.widgetEditor.changeSelectedDevicePlatform(e.target.value)
  onNewWidgetTypeChange: (e) => @props.widgetEditor.changeSelectedWidgetType(e.target.value)
  onNewDeviceChange: (e) => @props.widgetEditor.changeSelectedDevice(e.target.value)
  onNewWidgetLabelChange: (value) => @props.widgetEditor.changeNewWidgetLabel(value)
  addNewWidget: =>
    @props.editor.addWidget()
    @props.modal.closeModal()
  cancelAddNewWidget: => @props.modal.closeModal()

  render: ->
    {widgetEditor} = @props
    console.log widgetEditor.selectedWidgetProperties
    div className: 'create-widget-dialog', =>
      crel SelectNewWidgetPlatform, widgetEditor: widgetEditor, onChange: @onNewWidgetDevicePlatformChange
      br()
      crel SelectNewWidgetType, widgetEditor: widgetEditor, onChange: @onNewWidgetTypeChange
      br()
      crel SelectNewDeviceId, widgetEditor: widgetEditor, onChange: @onNewDeviceChange
      br()
      crel InputNewWidgetLabel, widgetEditor: widgetEditor, onChange: @onNewWidgetLabelChange
      br()
      br()
      div className: 'pt-dialog-footer', =>
        div className: "pt-dialog-footer-actions", =>
          crel AddNewWidgetButton, widgetEditor: widgetEditor, onClick: @addNewWidget

          crel Button,
            text: 'CANCEL'
            intent: Intent.DANGER
            className: 'pt-large'
            onClick: @cancelAddNewWidget


module.exports = inject('widgetEditor', 'editor')(observer(AddNewWidgetDialogContent))

