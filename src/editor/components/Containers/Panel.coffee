import React from 'react'
import {crel, div, input, text,span } from 'teact'
import {inject, observer} from 'mobx-react'
import FloatingPanel from '../FloatingPanel'
import cx from 'classnames'


class PanelContainer extends React.Component
  constructor: (props) ->
    super (props)
  componentDidMount: -> @props.store.setComponent @props.id, @rnd

  render: ->
    {panel} = @props
    class_name = cx(
      "z-depth-3": yes
      hidden: !panel.isShowing
    )
    crel FloatingPanel,
      ref: ((c) => @rnd = c)
      style: panel.style
      zIndex: 250
      className: class_name
      bounds: 'parent'
      initial: panel.initial
      minWidth: panel.minWidth
      maxWidth: panel.maxWidth
      minHeight: panel.minHeight
      maxWidth: panel.maxWidth
      maxHeight: panel.maxHeight, =>
        crel 'div', @props.children






SettingsPanelContainer = inject(({panel}, {id}) => ({

    store: panel
    panel: panel.panels[id]
}))(observer(PanelContainer))

export default SettingsPanelContainer