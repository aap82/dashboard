import React from 'react'
import {extendObservable, observable, toJS} from 'mobx'
import {crel, div, a, h5, h4, select, option, pureComponent,br } from 'teact'
import {inject, observer} from 'mobx-react'
import {Button, Intent, Switch} from '@blueprintjs/core'
import EditableText from '../components/EditableText'
import GroupWidgetEditor from './Widgets/GroupWidgetEditor'
import WidgetStyle from './Widgets/WidgetStyleEditor'

keys =
  CTRL: 17
  ESC: 27
  LEFT: 37
  UP: 38
  RIGHT: 39
  DOWN: 40


WidgetProp = observer((props) ->
  value = props.value * (props.multiplier or 1) + if props.postFix? then props.postFix else ''
  div style: {marginBottom: props.marginBottom}, className: 'row between middle', =>
    div props.label
    div value
)
WidgetStaticLayoutSwitch =  observer(({marginBottom, label, obj, checked, onChange}) ->
  div style: {marginBottom:  marginBottom}, className: 'row between middle', ->
    div style: {width: '100%'}, ->
      crel Switch,
        label: label
        className: 'pt-fill pt-align-right'
        checked: obj.static
        onChange: onChange

)

WidgetPropsSwitch = observer(({marginBottom, label, obj, checked, onChange}) ->
  div style: {marginBottom:  marginBottom}, className: 'row between middle', ->
    div style: {width: '100%'}, ->
      crel Switch,
        label: label
        className: 'pt-fill pt-align-right'
        checked: obj[checked]
        onChange: onChange

)

class SingleWidgetEditor extends React.Component
  constructor: (props) ->
    @layoutIndex = 0
    for l, i in props.editor.dashboard.layouts when l is props.layout
      @layoutIndex = i
    extendObservable @, {
      isEditing: yes
      controlKey: no

    }
  componentDidMount: =>   document.addEventListener('keydown', @handleKeyDown)
  componentWillUnmount: =>   document.removeEventListener('keydown', @handleKeyDown)


  handleWidgetPositionChange: (keyCode) =>
    {editor, layout} = @props
    switch keyCode
      when keys.UP
        if layout.y > 0
          layout.y = layout.y - 1
          editor.updateDashboard()
      when keys.DOWN
        layout.y = layout.y + 1
        editor.updateDashboard()
      when keys.LEFT
        if layout.x > 0
          layout.x = layout.x - 1
          editor.updateDashboard()
      when keys.RIGHT
        layout.x = layout.x + 1
        editor.updateDashboard()

  handleWidgetResize: (keyCode) =>
    {editor, layout} = @props
    switch keyCode
      when keys.UP
        if layout.h > layout.minH
          layout.h = layout.h - 1
          editor.updateDashboard()
      when keys.DOWN
        layout.h = layout.h + 1
        editor.updateDashboard()
      when keys.LEFT
        if layout.w > layout.minW
          layout.w = layout.w - 1
          editor.updateDashboard()
      when keys.RIGHT
        layout.w = layout.w + 1
        editor.updateDashboard()


  ctrlKeyUP: (e) =>
    if e.keyCode is keys.CTRL
      @controlKey = no
      document.removeEventListener('keyup', @ctrlKeyUP)

  handleKeyDown: (e) =>
    {editor, layout} = @props
    if e.keyCode is keys.ESC
      editor.editingWidgets.clear()
      editor.editingLayouts.clear()
    if e.keyCode is keys.CTRL
      @controlKey = yes
      document.addEventListener('keyup', @ctrlKeyUP)
    else if !layout.static
      switch @controlKey
        when no then @handleWidgetPositionChange(e.keyCode)
        when yes then @handleWidgetResize(e.keyCode)

  deleteWidget: =>
    {widget, layout, editor} = @props
    editor.editingWidgets.remove(widget)
    editor.editingLayouts.remove(layout)
    editor.dashboard.widgets.remove(widget)

  toggleStatic: (e) =>
    {layout, editor} = @props
    layout.static = !layout.static
    editor.updateDashboard()


  toggleStyleOverride: (e) =>
    {widget, editor} = @props
    widget.toggleStyleOverride()


  handleWidgetLabelSave: (id, value) =>
    {widget} = @props
    widget.label = value

  handleWidgetLabelChange: (value) =>
    @props.widget.label = value

  render: ->
    {widget, layout, dashboard, editor} = @props
    {rowHeight} = dashboard
    {label} = widget
    {x, y, w, h} = layout
    div style: {paddingLeft: 5, paddingRight: 5, paddingTop: 10}, className: 'content', =>
      div style: {marginBottom: 5}, className: 'row center middle', =>
        h5 'Widget Properties'
      div style: {marginBottom: 10}, className: 'row between middle', =>
        div 'Label'
        crel EditableText,
          id: 'label'
          type: 'div'
          live: yes
          obj: widget
          text: label
          onChange: @handleWidgetLabelChange
          onSave: @handleWidgetLabelSave
      crel WidgetStaticLayoutSwitch,
        marginBottom: 8
        label: 'Is Static?'
        obj: layout
        checked: 'static'
        onChange: @toggleStatic
      crel WidgetProp,
          label: 'Widget Height'
          marginBottom: 8
          value: h
          multiplier: rowHeight
          postFix: 'px'
      crel WidgetProp,
        label: 'Widget Width'
        marginBottom: 15
        value: w
        postFix: 'px'
      crel WidgetProp,
        label: 'Position X - start'
        marginBottom: 5
        value: x
      crel WidgetProp,
        label: 'Position X - end'
        marginBottom: 15
        value: x + w
      crel WidgetProp,
        label: 'Position Y - start'
        marginBottom: 5
        value: y
        multiplier: rowHeight
      crel WidgetProp,
        label: 'Position Y - end'
        marginBottom: 45
        value: y + h
        multiplier: rowHeight
      crel WidgetPropsSwitch,
        marginBottom: 5
        label: 'Override Global Style?'
        obj: widget
        checked: 'overrideStyle'
        onChange: @toggleStyleOverride
      crel WidgetStyle, editor: editor
      div style: {marginBottom: 15}, className: 'row around middle', =>
        crel Button,
          text: 'Delete Widget'
          intent: Intent.DANGER
          onClick: @deleteWidget





class WidgetEditor extends React.Component
  render: ->
    {editor} = @props
    {editingWidgets, editingLayouts, dashboard} = editor
    if !editor.isEditing or editor.editingWidgets.length is 0
      div style: {paddingLeft: 5, paddingRight: 5, paddingTop: 10}, className: 'content', =>
        div style: {marginBottom: 8}, className: 'row center middle', =>
          h5 'Widget Properties'
    else if editor.editingWidgets.length is 1
      crel SingleWidgetEditor, editor: editor, widget: editingWidgets[0], layout: editingLayouts[0], dashboard: dashboard

    else
      crel GroupWidgetEditor, editor: editor, widgets: editingWidgets, layouts: editingLayouts, dashboard: dashboard







WidgetEditor = observer(WidgetEditor)
export default WidgetEditor





