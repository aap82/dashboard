React = require 'react'
{crel, div, span, text} = require 'teact'
{ observer} = require 'mobx-react'
ColorPicker = require('rc-color-picker')

exports = module.exports
class DashboardColorPicker extends React.Component
  handleDashboardChange: (colors) =>
    {dashboard} = @props
    dashboard.setStyleProp('backgroundColor', colors.color) if colors.color isnt  dashboard.dashboardStyle.backgroundColor
    return

  render: ->
    {dashboard, editor} = @props
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{dashboard.dashboardStyle.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: dashboard.dashboardStyle.backgroundColor
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
    editor.setWidgetEditorProp('backgroundColor', colors.color) if colors.color isnt editor.widgetProps.backgroundColor
    editor.setWidgetEditorProp('backgroundAlpha', colors.alpha) if colors.alpha isnt editor.widgetProps.backgroundAlpha
    return
  render: ->
    {editor} = @props
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{editor.widgetProps.backgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: editor.widgetProps.backgroundColor
            alpha: editor.widgetProps.backgroundAlpha
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetColorChange, =>
              span className: 'rc-color-picker-trigger'

class WidgetFontColorPicker extends React.Component
  handleWidgetFontColorChange: (colors) =>
    {editor} = @props
    editor.setWidgetEditorProp('color', colors.color) if colors.color isnt editor.widgetProps.fontColor
    return
  render: ->
    {editor} = @props
    className = if !editor.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Font Color'
      div className: 'color-picker-text', =>
        text "#{editor.widgetProps.color}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: editor.widgetProps.color
            alpha: 100
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetFontColorChange, =>
              span className: 'rc-color-picker-trigger'

exports.DashboardColorPicker = observer(DashboardColorPicker)
exports.WidgetBackgroundColorPicker = observer(WidgetBackgroundColorPicker)
exports.WidgetFontColorPicker = observer(WidgetFontColorPicker)










