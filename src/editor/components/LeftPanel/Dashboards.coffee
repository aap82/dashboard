import React from 'react'
import {extendObservable, computed, expr} from 'mobx'
import {crel, div, text, label, button, select, option, pureComponent,br, ul, li,h5, h6,input,span  } from 'teact'
import {inject, observer} from 'mobx-react'

import { Button, Intent, Checkbox} from  '@blueprintjs/core'
import cx from 'classnames'


class DashboardItem extends React.Component
  render: ->
    {editor, dashboard} = @props
    isSelected = expr(-> editor.selectedDashboardID is dashboard.uuid)
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
          h6 style: marginTop: 2,
            "#{dashboard.title}"

  selectDashboard: =>
    {dashboard, editor} = @props
    editor.selectDashboard dashboard





DashboardItem = observer(DashboardItem)

DashboardList = inject('editor')(observer(({editor}) ->
  div ->
    if editor.device?
      editor.getDashboards().forEach (dashboard) ->
        crel DashboardItem,
          dashboard: dashboard
          editor: editor
        li className: 'pt-menu-header'
    else
      null
))
export default DashboardList



