React = require 'react'
{extendObservable, toJS} = require 'mobx'
{crel, div, text, label, button, select, option, pureComponent,br } = require 'teact'
{inject, observer} = require 'mobx-react'
{ Button, Intent} = require('@blueprintjs/core')





DashboardDropDownListView = (observer(({value, editor, onChange}) ->
  displayName: 'SelectDashboardListView'
  div className: 'pt-select pt-large pt-fill', ->
    select value: value, onChange: onChange, disabled: editor.isEditing, ->
      option value: 0, 'Select Dashboard...'
      editor.getDashboardsForDevice().map (dashboard) ->
        option key: dashboard.uuid, value: dashboard.uuid, "#{dashboard.title}" #" / #{dashboard.deviceType}"
))





class UserDashboardsSection extends React.Component
  constructor: (props) ->
    extendObservable @, {
      value: 0

    }

  onChange: (e) =>
    {editor} = @props
    editor.load(e.target.value)
    @value = e.target.value

  createDashboard: =>
    console.log('hi')
    return


  render: ->
    {editor} = @props
    div style: {paddingLeft: 10, paddingRight: 10}, className: 'content', =>
      div className: 'row between middle', =>
        div style: {width: '70%'}, =>
          crel DashboardDropDownListView, value: @value, editor: editor, onChange: @onChange
        crel Button,
          text: 'Create'
          disabled: editor.isEditing
          className: 'pt-large'
          intent: Intent.SUCCESS
          onClick: @createDashboard






module.exports = observer(UserDashboardsSection)


