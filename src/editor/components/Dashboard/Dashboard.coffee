import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import ReactGridLayout from 'react-grid-layout'
import SwitchWidget from '../../../widgets/SwitchWidget'


class Dashboard extends React.Component
  render: ->
    {grid} = @props
    div style: {
      height:'100%'
      width: '100%'
    }, =>
      crel ReactGridLayout,
        verticalCompact: no
        autoSize: no
        cols: grid.cols
        margin: [grid.marginX, grid.marginY]
        containerPadding: [0, 0]
        rowHeight: grid.rowHeight
        width: grid.width
        maxRows: grid.maxRows
        layout: [{i: '1', x: 5, y: 5, h: 90, w: 90}]
        onLayoutChange: @handleLayoutChange, =>
          div key: '1', style: backgroundColor: 'yellow', ->
            crel SwitchWidget

Dashboard = observer(Dashboard)
export default Dashboard






