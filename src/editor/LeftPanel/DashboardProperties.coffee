import React from 'react'
import {crel, div, select, input, option, br, h4, h3, label, text } from 'teact'
import { inject, observer} from 'mobx-react'
import MenuButton from './../components/MenuButton'
import { Button, Intent, EditableText} from '@blueprintjs/core'
import ColorPickerComponent from './ColorPicker'
import t from './buttons/types'
import TextInput from '../forms/components/TextInput'
import Select from '../forms/components/Select'



class WidgetFontSize extends React.Component
  constructor: (props) ->
    super props

  increment: =>
    {editor, dashboard, id} = @props
    editor.dashboard[id] = editor.dashboard[id] + 1


  decrement: =>
    {editor, id} = @props
    editor.dashboard[id] = editor.dashboard[id] - 1



  render: =>
    {editor, id} = @props
    {dashboard} = editor
    value = dashboard[id]
    disabled = !editor.isEditing
    div className: 'col-xs-6 widget-font-input-container', =>
      div className: 'row middle end', =>
        div className: 'input-section', =>
          input
            id: @props.id
            className: 'pt-input pt-rtl number-input'
            value: dashboard[id]
            type: 'text'
            onChange: -> return
            disabled: disabled
            autoFocus: yes
        crel Button, iconName: 'plus', disabled: (value is 25 or disabled ), onClick: @increment
        crel Button, iconName: 'minus', disabled:(value is 12 or disabled ), onClick: @decrement


WidgetFontSize = observer(WidgetFontSize)



Title = observer(({editor, dashboard}) ->
  div style: {paddingRight: 10}, className: 'row between middle', ->
    h4 'Title'
    h4 ->
      crel EditableText,
        className: 'pt-rtl pt-fill'
        placeholder: dashboard.title
        value: dashboard.title
        disabled: !editor.isEditing
        selectAllOnFocus: yes
        onChange: ((value) => dashboard.title = value)
        intent: if editor.isEditing then Intent.SUCCESS else Intent.NONE
)
class DashboardDeviceOrientation extends React.Component
  changeDeviceOrientation: (e) =>
    {editor} = @props
    editor.setDashboardOrientationTo(e.target.value)

  render: ->
    {editor} = @props
    div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 0}, =>
      div className: 'row between middle', =>
        div 'Device Orientation'
        div className: 'pt-select', =>
          select onChange: @changeDeviceOrientation, value: editor.dashboardOrientation, disabled: !editor.isEditing, ->
            option key: 'landscape', value: 'landscape', "Landscape"
            option key: 'portrait', value: 'portrait', "Portrait"




DashboardDeviceOrientation = observer(DashboardDeviceOrientation)

class DashboardProperties extends React.Component

  render: ->
    {editor, dashboard, forms} = @props
    if editor.selectedDashboardId is '0' then return null
    {isEditing} = editor
    div className: 'properties-section', =>
      h4 "#{forms.dashboard.changed}"
      h4 "#{forms.dashboard.isDirty}"
      div className: 'title-row button', =>
        crel Button,
          text: 'Dashboard'
          iconName: 'caret-down'
          className: 'pt-minimal pt-fill pt-large'
      div style: {marginBottom: 12}, className: 'title-editor', =>
        crel Title, editor: editor, dashboard: dashboard
      div style: {paddingLeft: 5, paddingRight: 5}, className: 'row between middle', ->
        crel TextInput,
          field: forms.dashboard.$('title')
          showLabel: yes
          large: no
        crel Select,
          showLabel: yes
          field: forms.dashboard.$('orientation')
      crel DashboardDeviceOrientation,
        editor: editor
      br()
      div style: {paddingLeft: 5, marginRight: -7}, =>
        crel ColorPickerComponent,
          picker: dashboard,
          target: 'backgroundColor',
          alpha: false,
          isEditing: isEditing,
          label: 'Background Color'
      div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 5}, =>
        div className: 'row between middle', =>
          div 'Primary Font Size'
          crel WidgetFontSize,
            id: 'widgetFontSizePrimary'
            editor: editor
            dashboard: dashboard
        div className: 'row between middle', =>
          div 'Primary Font Weight'
          div dashboard.widgetFontWeightPrimary
        div className: 'row between middle', =>
          div 'Secondary Font Size'
          crel WidgetFontSize,
            id: 'widgetFontSizeSecondary'
            editor: editor
            dashboard: dashboard
        div className: 'row between middle', =>
          div 'Secondary Font Weight'
          div dashboard.widgetFontWeightSecondary






DashboardProperties = inject('forms')(observer(DashboardProperties))
export default DashboardProperties










