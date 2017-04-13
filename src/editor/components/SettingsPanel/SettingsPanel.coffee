import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import GridProperties from './GridProperties'
import SectionTitle from './SectionTitle'
import cx from 'classnames'




SettingsPanelView = observer(class SettingsPanelView extends React.Component
  render: ->
    {settings} = @props
    {grid} = settings
    div =>
      div style: height: 10
      crel SectionTitle, title: 'Grid Properties'
      crel GridProperties, grid: grid
)

export default SettingsPanelView