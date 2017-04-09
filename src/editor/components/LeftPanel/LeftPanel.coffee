import React from 'react'
import {crel, div, input, h3, br, ul, li, h5, h6,button,span} from 'teact'
import {inject, observer} from 'mobx-react'
import UserDeviceList from './UserDevices'
import DashboardList from './Dashboards'
import cx from 'classnames'
import {EditableText, Intent} from '@blueprintjs/core'
import {extendObservable, observable, computed, runInAction, action} from 'mobx'

AddNewButton = observer(({editor, onClick}) ->
  buttonClass = cx(
    "pt-menu-item": yes
    "pt-button": yes
    "pt-disabled": !editor.device?
    "pt-icon-plus": yes
  )
  textClass = cx("pt-text-muted": !editor.device?)
  li ->
    button type: 'button',
      className: buttonClass
      disabled: !editor.device?
      onClick: onClick, ->
        h6 className: textClass, "Add New"
)

class DashboardTitleInput extends React.Component
  constructor: ->
    extendObservable @, {title: '' }

  render: ->
    div className: "row middle", style: padding: 6,marginLeft: 1, => #
      span className: "pt-icon-standard pt-icon-plus"
      div style: marginLeft: 8, =>
        crel EditableText,
          confirmOnEnterKey: yes
          intent: Intent.NONE
          defaultValue: 'Enter New Title'
          value: @title
          isEditing: yes
          selectAllOnFocus: yes
          onCancel: @handleCancel
          onChange: @handleTitleChange
          onConfirm: @handleConfirm

  handleConfirm: =>
    if @title is '' then return @handleCancel()
    @props.editor.createDashboard(@title)
    @title = ''


  handleTitleChange: (value) => @title = value
  handleCancel: =>
    @title = ''
    @props.editor.isAddingDashboard = no


DashboardTitleInput = observer(DashboardTitleInput)


class AddNewDashboard extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {editor} = @props
    switch editor.isAddingDashboard
      when yes then  crel DashboardTitleInput, editor: editor
      else
        crel AddNewButton,
          editor: editor
          onClick: @addNewButtonPress


  addNewButtonPress: => @props.editor.isAddingDashboard = yes

AddNewDashboard = inject('editor')(observer(AddNewDashboard))

export LeftPanel = =>
  div className: 'pt-dark left-panel', =>
    div style: {paddingLeft: 10, paddingRight: 10}, className: 'content', =>
      ul className: 'pt-menu pt-elevation-1', =>
        li className: 'pt-menu-header', ->
          h5 'Devices'
        li className: 'pt-menu-header'
        crel UserDeviceList
      br()
      ul className: 'pt-menu pt-elevation-1', =>
        li className: 'pt-menu-header', ->
          h5 'Dashboards'
        li className: 'pt-menu-header'
        crel DashboardList
        crel AddNewDashboard
        li className: 'pt-menu-header'




