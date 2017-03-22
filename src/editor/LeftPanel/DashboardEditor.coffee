import React from 'react'
import {extendObservable, observable, toJS} from 'mobx'
import {crel, div, text, h5, h4, select, option, pureComponent,br } from 'teact'
import {inject, observer} from 'mobx-react'
import MenuButton from '../components/MenuButton'
import t from './buttons/types'



class DashboardEditor extends React.Component
  handleSave: (id, value) =>
    console.log id, value

  render: ->
    {editor} = @props
    {dashboard, buttons} = editor
    {EDIT_DASHBOARD,SAVE_DASHBOARD,DONE_EDITING,DISCARD_CHANGES,COPY_DASHBOARD,} = buttons
    not_selected = if editor.selectedDashboardId is '0' then yes else no
    div =>
      div style: {paddingLeft: 5, paddingRight: 5, paddingTop: 15}, className: 'row center middle', =>
        div style: {width: 250, marginBottom: 5},  =>
          div style: {marginBottom: 4}, className: 'row center middle', =>
            h5 'Dashboard Properties'
          div style: {marginBottom: 4}, className: 'row between middle', =>
            div 'Height'
            div if not_selected then '' else dashboard.height
          div style: {marginBottom: 4}, className: 'row between middle', =>
            div 'Columns'
            div if not_selected then '' else dashboard.cols
          div style: {marginBottom: 0}, className: 'row between middle', =>
            div 'Row Height'
            div if not_selected then '' else dashboard.rowHeight
      div style: {paddingLeft: 5, paddingRight: 5}, className: 'row center middle', =>
        div style: {width: 300},  =>
          div style: {padding: 5}, className: 'row around middle', =>
            crel MenuButton, buttons: [EDIT_DASHBOARD, SAVE_DASHBOARD, DONE_EDITING], editor: editor, onClick: @handleClick
            crel MenuButton, buttons: [COPY_DASHBOARD, DISCARD_CHANGES ], editor: editor, onClick: @handleClick

  handleClick: (e) =>
    {editor} = @props
    switch e.currentTarget.id
      when t.EDIT_DASHBOARD
        return if editor.selectedDashboardId is '0'
        editor.startEditing()
        break
      when t.DONE_EDITING
        editor.stopEditing()
        break
      when t.DISCARD_DASHBOARD
        editor.restoreSnapshot()
      when t.SAVE_DASHBOARD
        editor.save()
        break



export default observer(DashboardEditor)





