React = require 'react'
{crel, div, br, text} = require 'teact'
{Button} = require('@blueprintjs/core')
{WidgetBackgroundColorPicker, WidgetFontColorPicker} = require './ColorPicker'
DashboardItem = require './DashboardItem'

BaseWidgetPropertiesTitleButton = ->
    crel Button,
      text: 'Base Widget Properties'
      iconName: 'caret-down'
      className: 'pt-minimal pt-fill pt-large'


class BaseWidgetPropertiesContent extends React.Component
  render: ->
    {dashboard} = @props
    getProps = (id) ->
      id: id
      dashboard: dashboard
    div className: 'content', ->
      crel WidgetBackgroundColorPicker, dashboard: dashboard
      crel WidgetFontColorPicker, dashboard: dashboard
      div className: 'widget-props row middle between', ->
        text 'Border Radius'
        crel DashboardItem, getProps('widgetBorderRadius', 'Border Radius')
      div className: 'widget-props row middle between', ->
        text 'Card Depth'
        crel DashboardItem, getProps('widgetCardDepth', 'Card Depth')
      br()


BaseWidgetProperties = (props) ->
  div className: 'properties-section', ->
    div className: 'title-row', ->
      crel BaseWidgetPropertiesTitleButton
    crel BaseWidgetPropertiesContent, props




module.exports = BaseWidgetProperties