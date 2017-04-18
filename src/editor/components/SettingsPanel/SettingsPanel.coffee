import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'

import Grid from './Grid'
import WidgetStyle from './WidgetStyle'

import cx from 'classnames'
import {Tab2, Tabs2 } from '@blueprintjs/core'



SettingsPanel = inject('editor')(observer(class SettingsPanel extends React.Component
  render: ->
    {settings, panel} = @props
    {grid, widgetStyle, widgetFont} = settings
    gridTab = crel(Grid, {grid: grid, settings: panel.settings})
    widgetStyleTab = crel(WidgetStyle, {widgetStyle: widgetStyle, settings: panel.settings})
    crel Tabs2,
      id: 'SettingsPanelTabs'
      animate: yes,
      renderActiveTabPanelOnly: no
      selectedTabId: panel.settings.tab
      onChange: @handleTabChange, =>
        crel Tab2,
          id: 'grid',
          title: 'Grid',
          panel: gridTab
        crel Tab2,
          id: 'widgetStyle',
          title: 'Widget Style',
          panel: widgetStyleTab
        crel Tab2,
          id: 'grid3',
          title: 'Widget Font',
          panel: gridTab

  handleTabChange: (id) => @props.panel.settings.tab = id
))

export default SettingsPanel
