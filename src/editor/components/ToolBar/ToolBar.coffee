import React from 'react'
import {crel, div, input, h4,  button,label, select, option, text,span,br} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import {expr} from 'mobx'

Button = observer((props) ->
  buttonClass = cx(
    "pt-button": yes
    "pt-large": yes
    "pt-icon": yes
    "pt-intent-#{props.intent}": yes
    "pt-icon-#{props.icon}": yes
    "pt-disabled": props.disabled
    "pt-active": props.isActive

  )
  div style: marginBottom: 20, 'row middle center', ->
    button type: 'button',
      className: buttonClass
      disabled: props.disabled
      onClick: props.onClick

)
DeleteButton = observer(({editor, onClick}) ->
  disabled = expr(-> editor.selectedDashboardID is '')
  crel Button,
    icon: 'trash',
    intent: 'danger'
    disabled: disabled
    onClick: onClick
)

ResetButton = observer(({editor, onClick}) ->
  crel Button,
    icon: 'refresh',
    intent: 'danger'
    disabled: !editor.isDirty
    onClick: onClick
)

TogglePanel = observer(({app, onClick}) ->
  crel Button,
    icon: 'edit',
    intent: 'primary'
    isActive: app.isSettingsPanelVisible
    onClick: onClick
)

SaveButton = observer(({editor, onClick}) ->
  crel Button,
    icon: 'floppy-disk',
    intent: 'success'
    disabled: !editor.isDirty
    onClick: onClick
)

ToolBar = inject('app', 'editor')(class ToolBar extends React.Component
    constructor: (props) ->
      super props

    render: ->
      {editor, app} =@props
      div className: 'center', =>
        crel TogglePanel,
          app: app
          onClick: @handleButtonPress
        crel SaveButton,
          editor: editor
          onClick: @handleSave
        crel ResetButton,
          editor: editor
          onClick: @handleRestore
        br()
        br()
        br()
        crel DeleteButton,
          editor: editor
          onClick: @handleDelete

    handleSave: => @props.editor.save()
    handleButtonPress: => @props.app.isSettingsPanelVisible = !@props.app.isSettingsPanelVisible
    handleRestore: => @props.editor.restore()
    handleDelete: => @props.editor.deleteDashboard()


)
export default ToolBar