React = require 'react'
{crel, div, span, text} = require 'teact'
{inject, observer} = require 'mobx-react'
ColorPicker = require('rc-color-picker')

exports = module.exports
class DashboardColorPicker extends React.Component
  handleDashboardChange: (colors) =>
    @props.editor.setStyleProp('backgroundColor', colors.color)
    return

  render: ->
    {editor} = @props
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{editor.style.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: editor.style.backgroundColor
            alpha: 100
            mode: 'RGB'
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleDashboardChange, =>
              span className: 'rc-color-picker-trigger'


class WidgetBackgroundColorPicker  extends React.Component
  handleWidgetColorChange: (colors) =>
    {editor} = @props
    editor.setWidgetProp('backgroundColor', colors.color) if colors.color isnt editor.widgetProps.backgroundColor
    editor.setWidgetProp('backgroundAlpha', colors.alpha) if colors.alpha isnt editor.widgetProps.backgroundAlpha
    return
  render: ->
    {editor} = @props
    {viewModel} = editor
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{viewModel.widgetProps.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: viewModel.widgetProps.backgroundColor
            alpha: viewModel.widgetProps.backgroundAlpha
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetColorChange, =>
              span className: 'rc-color-picker-trigger'

class WidgetFontColorPicker extends React.Component
  handleWidgetFontColorChange: (colors) =>
    {editor} = @props
    editor.setWidgetProp('color', colors.color) if colors.color isnt editor.widgetProps.fontColor
    return
  render: ->
    {editor} = @props
    {viewModel} = editor
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Font Color'
      div className: 'color-picker-text', =>
        text "#{viewModel.widgetProps.color}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: viewModel.widgetProps.color
            alpha: 100
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetFontColorChange, =>
              span className: 'rc-color-picker-trigger'



exports.DashboardColorPicker = inject('editor')(observer(DashboardColorPicker))
exports.WidgetBackgroundColorPicker = inject('editor')(observer(WidgetBackgroundColorPicker))
exports.WidgetFontColorPicker = inject('editor')(observer(WidgetFontColorPicker))










