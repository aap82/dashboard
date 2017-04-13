import React from 'react'
import {crel, div, input, text,span } from 'teact'
import {inject, observer} from 'mobx-react'
import FloatingPanel from '../FloatingPanel'
import cx from 'classnames'


class SettingsPanelContainer extends React.Component
  constructor: (props) ->
    super (props)
  componentDidMount: ->    @props.panel.component = @rnd


  render: ->
    {panel, app} = @props

    class_name = cx(
      "z-depth-3": yes
      hidden: !app.isSettingsPanelVisible
    )
    crel FloatingPanel,
      ref: ((c) => @rnd = c)
      style:
        backgroundColor:  "rgba(0, 2, 0, 0.85)"
        borderColor: 'black'
        borderWidth: 1
        borderStyle: 'solid'
      zIndex: 250
      className: class_name
      bounds: 'parent'
      initial: panel.initial
      minWidth: panel.minWidth
      maxWidth: panel.maxWidth
      minHeight: panel.minHeight
      maxWidth: panel.maxWidth
      maxHeight: panel.maxHeight
      onResize: @updateSizeProps,      =>
        div =>
          crel 'div', @props.children


  updateSizeProps: (e, size, client, delta, newPos ) =>
    @props.panel.setPanelSize(size)





SettingsPanelContainer = observer(SettingsPanelContainer)

export default SettingsPanelContainer