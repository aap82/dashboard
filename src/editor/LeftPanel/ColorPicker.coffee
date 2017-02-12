React = require 'react'
{crel, div, span, text} = require 'teact'
{inject, observer} = require 'mobx-react'
ColorPicker = require('rc-color-picker')

exports = module.exports
class DashboardColorPicker extends React.Component
  handleDashboardChange: (colors) =>
    {dashboard} = @props.editorView
    dashboard.backgroundColor = colors.color
    return

  render: ->
    {editorView} = @props
    {dashboard} = editorView
    className = if !editorView.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{dashboard.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: dashboard.backgroundColor
            alpha: 100
            mode: 'RGB'
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleDashboardChange, =>
              span className: 'rc-color-picker-trigger'


class WidgetBackgroundColorPicker  extends React.Component
  handleWidgetColorChange: (colors) =>
    {widgetProps} = @props.editorView
    widgetProps.backgroundColor = colors.color
    widgetProps.backgroundAlpha = colors.alpha
    return

  render: ->
    {editorView} = @props
    {widgetProps} = editorView
    className = if !editorView.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{widgetProps.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: widgetProps.backgroundColor
            alpha: widgetProps.backgroundAlpha
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetColorChange, =>
              span className: 'rc-color-picker-trigger'

class WidgetFontColorPicker extends React.Component
  handleWidgetFontColorChange: (colors) =>
    {widgetProps} = @props.editorView
    widgetProps.color = colors.color
    return

  render: ->
    {editorView} = @props
    {widgetProps} = editorView
    className = if !editorView.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Font Color'
      div className: 'color-picker-text', =>
        text "#{widgetProps.color}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: widgetProps.color
            alpha: 100
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetFontColorChange, =>
              span className: 'rc-color-picker-trigger'



exports.DashboardColorPicker = inject('editorView')(observer(DashboardColorPicker))
exports.WidgetBackgroundColorPicker = inject('editorView')(observer(WidgetBackgroundColorPicker))
exports.WidgetFontColorPicker = inject('editorView')(observer(WidgetFontColorPicker))










