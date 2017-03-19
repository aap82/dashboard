{crel, div, pureComponent} = require 'teact'
React = require 'react'
{inject, observer} = require 'mobx-react'
ReactGridLayout = require 'react-grid-layout'
{ WidthProvider}  = require 'react-grid-layout'
GridLayout = WidthProvider(ReactGridLayout)
WidgetContainer = require '../../widgets/Widget'
{crel, div} = require 'teact'
{sendCommand} = require('../../widgets/actions')


class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {dashboard} = @props
    div style: {
      height: '100%'
      maxWidth: '100%'
      backgroundColor: dashboard.backgroundColor
      color: 'white'
    }, =>
      crel GridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: no
        isResizable: no
        cols: dashboard.cols
        margin: [dashboard.marginX, dashboard.marginY]
        containerPadding: [0, 0]
        rowHeight: dashboard.rowHeight
        layout: dashboard.layouts.slice()
        Widgets(dashboard, sendCommand)

Widgets = pureComponent ( dashboard,  command) ->
  dashboard.widgets.map (widget) ->
    widget.sendCommand = command
    div key: widget.key, ->
      crel WidgetContainer, widget

module.exports = inject('dashboard')(observer(Dashboard))