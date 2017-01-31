React = require 'react'
{crel, div, h4, h5, br, text, select, option} = require 'teact'
{inject,observer} = require 'mobx-react'
{Intent, Button, EditableText} = require('@blueprintjs/core')


SaveWidgetChangesButton = ({onClick}) ->
  crel Button,
    text: 'Save'
    iconName: 'floppy-disk'
    onClick: onClick
    className: 'pt-large pt-fill'
    intent: Intent.PRIMARY

CancelWidgetChangesButton = ({onClick}) ->
  crel Button,
    text: 'Cancel'
    iconName: 'cross'
    onClick: onClick
    className: 'pt-large pt-fill'
    intent: Intent.DANGER


WidgetDevicePlatform = observer(({widgetEditor}) ->
  {activeDevice} =  widgetEditor
  div className: 'row between middle', ->
    text 'Device Platform:'
    div className: 'pt-select ', ->
      select disabled: yes, defaultValue: 0, ->
        option value: 0, activeDevice.platform
)


WidgetType = observer(({widgetEditor}) ->
  {activeWidget} =  widgetEditor
  div className: 'row between middle', ->
    text 'Widget Type:'
    div className: 'pt-select ', ->
      select disabled: yes, defaultValue: 0, ->
        option value: 0, activeWidget.type
)

WidgetLabel = observer(({widgetEditor, onChange}) ->
  {activeWidget} =  widgetEditor
  div className: 'row between middle', ->
    text 'Widget Label:'
    h5 ->
      crel EditableText,
        value: activeWidget.label
        selectAllOnFocus: yes
        onChange: onChange
)

WidgetDeviceType = observer(({widgetEditor}) ->
  {activeDevice} =  widgetEditor
  div className: 'row between middle', ->
    text 'Widget Device Id:'
    div className: 'pt-select ', ->
      select disabled: yes, defaultValue: 0, ->
        option value: 0, activeDevice.id
)




class EditWidgetDialogContent extends React.Component
  onLabelChange: (value) => @props.widgetEditor.setActiveWidgetLabel(value)
  saveWidgetChanges: =>
    @props.widgetEditor.saveEditChanges()
    @props.editor.closeModal()
  cancelWidgetChanges: =>
    @props.widgetEditor.cancelEditChanges()
    @props.editor.closeModal()



  render: ->
    {widgetEditor} = @props
    div className: 'create-widget-dialog', =>
      crel WidgetDevicePlatform, widgetEditor: widgetEditor
      br()
      crel WidgetType, widgetEditor: widgetEditor
      br()
      crel WidgetDeviceType, widgetEditor: widgetEditor
      br()
      crel WidgetLabel, widgetEditor: widgetEditor, onChange: @onLabelChange
      br()
      br()
      br()
      br()
      div className: 'pt-dialog-footer', =>
        div className: "pt-dialog-footer-actions", =>
          crel SaveWidgetChangesButton, onClick: @saveWidgetChanges
          crel CancelWidgetChangesButton, onClick: @cancelWidgetChanges



module.exports = inject('widgetEditor')(observer(EditWidgetDialogContent))

