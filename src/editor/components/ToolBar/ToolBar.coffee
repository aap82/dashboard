import React from 'react'
import {crel, div, input, h4,  button,label, select, option, text,span,br} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'
import {expr} from 'mobx'
import Button from '../Button'


CopyAndDeleteButton = observer(({editor, deleteClick, copyClick}) ->
  disabled = expr(-> editor.dashboard is null)
  if disabled
    null
  else
    div style: {height: 125}, className: 'column around', ->
      div ->
        crel Button,
          icon: 'duplicate',
          intent: 'primary'
          active: yes
          onClick: copyClick
      div ->
        crel Button,
          icon: 'trash',
          intent: 'danger'
          onClick: deleteClick


)

SaveAndResetButton = observer(({editor, saveClick, resetClick}) ->
  disabled = !editor.isDirty
  div style: {height: 125}, className: 'column around', ->
    div ->
      crel Button,
          icon: 'floppy-disk',
          intent: 'success'
          disabled: disabled
          onClick: saveClick
    div ->
      crel Button,
        icon: 'refresh',
        intent: 'danger'
        disabled: disabled
        onClick: resetClick
)
ToolBar = inject('app','editor')(class ToolBar extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    div style: {height: 310, marginTop: 30}, className: 'column between center', =>
      crel SaveAndResetButton,
        editor: editor
        saveClick: @handleSave
        resetClick: @handleRestore
      br()
      br()
      br()
      crel CopyAndDeleteButton,
        editor: editor
        copyClick: @handleCopy
        deleteClick: @handleDelete

  handleSave: =>
    console.log @props.editor.toJS()
    @props.editor.save()
  handleRestore: => @props.editor.restore()
  handleDelete: => @props.editor.deleteDashboard()
  handleCopy: => @props.editor.copyDashboard()


)
export default ToolBar