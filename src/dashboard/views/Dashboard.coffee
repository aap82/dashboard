import React from 'react'
import {crel, div} from 'teact'
import {inject, observer} from 'mobx-react'
import ReactGridLayout from 'react-grid-layout'
import WidgetContainer from '../../widgets/Widget'
import cx from 'classnames'
{sendCommand} = require '../../widgets/actions'


class Dashboard extends React.Component
  constructor: (props) ->
    super (props)

  render: ->
    {dashboard} = @props
    className = cx(
      'primary-font-size-'+ dashboard.widgetFontSizePrimary,
      'secondary-font-size-'+ dashboard.widgetFontSizeSecondary
    )
    div style: {
      height: dashboard.height
      width: dashboard.width
      backgroundColor: dashboard.backgroundColor
      color: 'white'
    }, className: className, =>
      crel ReactGridLayout,
        verticalCompact: no
        autoSize: no
        isDraggable: no
        isResizable: no
        cols: dashboard.cols
        margin: [dashboard.marginX, dashboard.marginY]
        containerPadding: [0, 0]
        rowHeight: dashboard.rowHeight
        width: dashboard.width
        layout: dashboard.layouts.slice(), =>
          for widget in dashboard.widgets
            div key: widget.key,  =>
              widget.sendCommand = sendCommand
              crel WidgetContainer, widget

export default inject('dashboard')(observer(Dashboard))