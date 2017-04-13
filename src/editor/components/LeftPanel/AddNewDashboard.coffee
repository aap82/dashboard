import React from 'react'
import {crel, div, input, h3, br, ul, li, h5, h6,button,span} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import {Intent} from '@blueprintjs/core'
import TextInput from '../TextInput'


export default AddNewDashboard = inject('editor')(observer(class AddNewDashboard extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    switch editor.isAddingDashboard
      when yes
        crel DashboardTitle,
          onConfirm: @onConfirm
          onCancel: @onCancel
      else
        crel AddNewButton,
          editor: editor
          onClick: @addNewButtonPress

  onCancel: => @props.editor.isAddingDashboard = no
  onConfirm: (title) => @props.editor.createDashboard(title)
  addNewButtonPress: => @props.editor.isAddingDashboard = yes

))

AddNewButton = observer(({editor, onClick}) ->
  buttonClass = cx(
    "pt-menu-item": yes
    "pt-button": yes
    "pt-intent-success": yes
    "pt-disabled": !editor.device?
    "pt-icon-plus": yes
  )
  textClass = cx(
    "pt-text-muted": !editor.device?
  )
  li ->
    button type: 'button',
      style: color: 'white'
      className: buttonClass
      disabled: !editor.device?
      onClick: onClick, ->
        h6 className: textClass,
          style: marginTop: 2
          "Add New"
)

DashboardTitle = observer(({onConfirm, onCancel}) ->
  div className: "row middle", style: {padding: 5, marginLeft: 1, fontSize: 16}, ->
    span className: "pt-icon-standard pt-icon-plus"
    div style: marginLeft: 8,  ->
      crel TextInput,
        element: 'div'
        value: 'Enter Title'
        onConfirm: onConfirm
        onCancel: onCancel
        intent: Intent.SUCCESS
        isEditing: yes

)