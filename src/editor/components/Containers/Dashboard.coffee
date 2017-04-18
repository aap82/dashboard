import React from 'react'
import {crel, div, input, text} from 'teact'
import {inject, observer} from 'mobx-react'
import Dashboard from '../Dashboard'


DashboardContainer = observer(class DashboardContainer extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {grid, editor} = @props
    {dashboard} = editor
    div style: {
      height: grid.height
      width: grid.width
      backgroundColor: "#{grid.backgroundColor}"
    },
      crel Dashboard, grid: grid






)

export default DashboardContainer

