import React from 'react'
import {extendObservable, computed} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br, ul, li,h5, h6,input,span  } from 'teact'
import {inject, observer} from 'mobx-react'
import { Button, Intent, Checkbox} from  '@blueprintjs/core'
import cx from 'classnames'


class DashboardItem extends React.Component
  render: ->
    {dashboard} = @props
    isSelected = (@props.selectedId is dashboard.uuid)
    labelClassName = cx(
      "pt-menu-item": yes
      "pt-icon-dashboard": yes
      "pt-active": isSelected
      "pt-intent-primary": isSelected
    )
    li className: 'row', =>
      button type: 'button',
        className: labelClassName
        onClick: @selectDashboard, ->
         h6 "#{dashboard.title}"

  selectDashboard: =>
    {dashboard, editor} = @props
    editor.selectDashboard dashboard





DashboardItem = observer(DashboardItem)

DashboardList = inject('app', 'editor')(observer(({app, editor}) ->
  {selectedDashboardId, device} = app
  if device?
    div ->
      device.dashboards.map (dashboard) ->
        {uuid} = dashboard
        crel DashboardItem,
          key: uuid
          dashboard: dashboard
          editor: editor
          selectedId: selectedDashboardId
        li className: 'pt-menu-header'
  else
    null
))
export default DashboardList



