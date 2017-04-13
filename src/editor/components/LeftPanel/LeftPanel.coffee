import React from 'react'
import {crel, div, br, ul, li, h5, h6} from 'teact'
import {inject, observer} from 'mobx-react'
import UserDeviceList from './UserDevices'
import DashboardList from './Dashboards'
import AddNewDashboard from './AddNewDashboard'




LeftPanel = =>
  div className: 'pt-dark left-panel', =>
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
        crel DashboardList
        crel AddNewDashboard
        li className: 'pt-menu-header'

export default LeftPanel