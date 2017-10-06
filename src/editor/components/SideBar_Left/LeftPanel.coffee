import React from 'react'
import {crel, div, br, ul, li, h5, h6, button} from 'teact'
import {inject, observer} from 'mobx-react'
import UserDeviceList from './UserDevices'
import DashboardList from './Dashboards'
import AddNewDashboard from './AddNewDashboard'
import WidgetSection from './Widgets'
import {expr} from 'mobx'
import cx from 'classnames'

AddWidget = inject('editor')(observer(({editor}) ->
  disabled = expr(-> editor.dashboard is null)
  if disabled
    return div ->
      null
  buttonClass = cx(
    "pt-button": yes
    "pt-intent-success": yes
    "pt-disabled": disabled
    "pt-text-muted": disabled
#    "pt-icon-plus": yes
  )
  textClass = cx(
    "pt-text-muted": disabled
  )
  button type: 'button',
#    style: color: 'white'
    className: buttonClass
    ->
      h6 className: textClass,
        "Add Widget"

))


LeftPanel = =>
  div className: 'pt-dark left-panel column between', =>
    div =>
      div style: {paddingLeft: 10, paddingRight: 10}, className: 'content middle', =>
        ul className: 'pt-menu pt-elevation-1', =>
          li className: 'pt-menu-header', ->
            h5 'Devices'
          li className: 'pt-menu-header'
          crel UserDeviceList
        br()
        ul className: 'pt-menu pt-elevation-1', =>
          li className: 'pt-menu-header', ->
            h5 'Dashboards'

          li className: 'pt-menu-header'
          crel AddNewDashboard
          li className: 'pt-menu-header'
          crel DashboardList


      br()
      div className: 'row center middle', =>
        crel AddWidget





export default LeftPanel