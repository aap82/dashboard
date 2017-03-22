import {extendObservable, action,toJS, runInAction} from 'mobx'
import React from 'react'
import {crel, div, text, br, input, select, option } from 'teact'
import {inject, observer} from 'mobx-react'
import {Intent, Button} from '@blueprintjs/core'
import Tappable from 'react-tappable/lib/Tappable'

class NewDashboardPanel extends React.Component
  constructor: (props) ->
    super props
    extendObservable(@, {
      title: ''
      changeTitle: action((e) => @title = e.target.value)
      createDashboard: action(=>
        {editor} = @props
        editor.create(@title)
        @props.close()

      )

    })

  render: ->
    div className: 'col-xs-12', =>
      br()
      crel TitleInput, dashboard: @dashboard, changeTitle: @changeTitle
      br()
      br()
#      crel DeviceTypeSelect, dashboard: @dashboard, editor: editor, changeType: @changeType
      br()
      br()
      div className: 'row around middle', =>
        div =>
          crel Button,
            intent: Intent.SUCCESS
            className: 'pt-large pt-fill'
            iconName: 'add'
            text: 'Add'
            onClick: @createDashboard
        div =>
          crel Button,
            className: 'pt-large pt-fill'
            intent: Intent.DANGER
            iconName: 'delete'
            text: 'Cancel'
            onClick: @props.close



TitleInput = observer((props) ->
  div className: 'row between middle', ->
    text 'Title'
    input
      className: 'pt-input pt-rtl pt-dark'
      value: props.title
      onChange: props.changeTitle
      placeholder: 'Dashboard Title'
      type: 'text'

)



export default inject('editor')(observer(NewDashboardPanel))
