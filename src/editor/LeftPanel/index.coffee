import React from 'react'
import {crel, div, h2, h3, h4, br, text} from 'teact'
import {inject, observer} from 'mobx-react'
import DashboardProps from './DashboardProperties'
import BaseWidgetProperties from './BaseWidgetProperties'
import MenuButton from './../components/MenuButton'
import UserDeviceProps from '../components/UserDeviceProps'
import UserDashboardsSection from '../components/UserDashboards'

class LeftPanel extends React.Component
  render: ->
    console.log 'render left panel'
    handleClick = =>  @props.editor.exit()
    {editor,  dashboard} = @props
    {buttons} = editor
    div className: 'pt-dark left-panel', =>
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel MenuButton, buttons: [buttons.EXIT_EDITOR], editor: editor, onClick: handleClick
            h2 'Editor'
      br()
      crel UserDeviceProps, editor: editor
      crel UserDashboardsSection, editor: editor
      crel DashboardProps, editor: editor, dashboard: dashboard
      crel BaseWidgetProperties, editor: editor, dashboard: dashboard



LeftPanel = inject(({editor, dashboards, modal}) => ({
  editor: editor
  modal: modal
  dashboard: dashboards.get(editor.selectedDashboardId)

}))(observer(LeftPanel))

export default LeftPanel







