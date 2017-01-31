React = require 'react'
{crel, div, span, h3, h4, h5, text, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')
ColorPicker = require('rc-color-picker')

exports = module.exports
class DashboardColorPicker extends React.Component
  handleDashboardChange: (colors) =>
    {dashboard} = @props
    dashboard.setProp('dashboardBackgroundColor', colors.color) if colors.color isnt  dashboard.dashboardBackgroundColor
    return

  render: ->
    {dashboard} = @props
    className = if !dashboard.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{dashboard.dashboardBackgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: dashboard.dashboardBackgroundColor
            alpha: 100
            mode: 'RGB'
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleDashboardChange, =>
              span className: 'rc-color-picker-trigger'


class WidgetBackgroundColorPicker  extends React.Component
  handleWidgetColorChange: (colors) =>
    {dashboard} = @props
    dashboard.setProp('widgetBackgroundColor', colors.color) if colors.color isnt dashboard.widgetBackgroundColor
    dashboard.setProp('widgetBackgroundAlpha', colors.alpha) if colors.alpha isnt dashboard.widgetBackgroundAlpha
    return
  render: ->
    {dashboard} = @props
    className = if !dashboard.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Background Color'
      div className: 'color-picker-text', =>
        text "#{dashboard.widgetBackgroundColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: dashboard.widgetBackgroundColor
            alpha: dashboard.widgetBackgroundAlpha
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetColorChange, =>
              span className: 'rc-color-picker-trigger'

class WidgetFontColorPicker extends React.Component
  handleWidgetFontColorChange: (colors) =>
    {dashboard} = @props
    dashboard.setProp('widgetFontColor', colors.color) if colors.color isnt  dashboard.widgetFontColor
    return
  render: ->
    {dashboard} = @props
    className = if !dashboard.isEditing then 'color-picker-disabled' else ''
    div className: 'color-picker-row widget-color-picker-row', =>
      text 'Font Color'
      div className: 'color-picker-text', =>
        text "#{dashboard.widgetFontColor}"
        div style: {margin: '15px 15px 15px', textAlign: 'center'}, className: className, =>
          crel ColorPicker,
            color: dashboard.widgetFontColor
            alpha: 100
            align:
              points: ['br', 'tl']
              offset: [0, 0]
            onChange: @handleWidgetFontColorChange, =>
              span className: 'rc-color-picker-trigger'

exports.DashboardColorPicker = observer(DashboardColorPicker)
exports.WidgetBackgroundColorPicker = observer(WidgetBackgroundColorPicker)
exports.WidgetFontColorPicker = observer(WidgetFontColorPicker)










