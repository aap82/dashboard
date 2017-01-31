React = require 'react'
{crel, div, span, h3, h4, h5, text, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')



class DashboardItem extends React.Component
  increment: =>
    {id, dashboard} = @props
    value = dashboard[id] + 1
    if id is 'widgetCardDepth' and value > 5 then value = 5
    return dashboard.setProp(id, value)
  decrement: =>
    {id, dashboard} = @props
    value = dashboard[id] - 1
    return if value < 0
    if id in ['cols', 'rowHeight']
      return if value is 0
    return dashboard.setProp(id, value)

  handleChange: (e) =>
    {id, dashboard} = @props
    return if e.target.value is ''
    value = parseInt(e.target.value)
    return dashboard.setProp(id, value)

  render: ->
    {id, title, dashboard} = @props
    div className: 'number-input-container', =>
      text title
      div className: 'input-section', =>
        input
          id: id
          className: 'pt-input pt-rtl number-input'
          value: dashboard[id]
          type: 'text'
          onChange: @handleChange
          disabled: !dashboard.isEditing
          autoFocus: yes
        crel Button, iconName: 'pt-icon pt-icon-plus toggle-icon', onClick: @increment, disabled: !dashboard.isEditing
        crel Button, iconName: 'pt-icon pt-icon-minus toggle-icon', onClick: @decrement, disabled: !dashboard.isEditing







module.exports = observer(DashboardItem)