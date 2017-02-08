React = require 'react'
{crel, div, span, h3, h4, h5, text, input, select, option } = require 'teact'
{inject, observer} = require 'mobx-react'
{Button} = require('@blueprintjs/core')



class DashboardItem extends React.Component
  render: ->
    {id, editor, increment, decrement, onChange} = @props
    div className: 'number-input-container', =>
      div className: 'input-section', =>
        input
          id: id
          className: 'pt-input pt-rtl number-input'
          value: editor.widgetProps[id]
          type: 'text'
          onChange: onChange
          disabled: !dashboard.isEditing
          autoFocus: yes
        crel Button, iconName: 'pt-icon pt-icon-plus toggle-icon', onClick: increment, disabled: !dashboard.isEditing
        crel Button, iconName: 'pt-icon pt-icon-minus toggle-icon', onClick: decrement, disabled: !dashboard.isEditing







module.exports = observer(DashboardItem)