React = require 'react'
{crel, div, h2, h3, h4, br, text} = require 'teact'
{inject, observer} = require 'mobx-react'
DashboardProps = require './DashboardProperties'
BaseWidgetProperties = require './BaseWidgetProperties'
MenuButton = require './../components/MenuButton'
UserDeviceProps = require '../components/UserDeviceProps'
UserDashboardsSection = require '../components/UserDashboards'

class LeftPanel extends React.Component
  render: ->
    console.log 'render left panel'
    handleClick = =>  @props.editor.exit()
    {editor} = @props
    {buttons} = editor
    div className: 'pt-dark left-panel', =>
      div className: 'row middle between', =>
        div style: {padding: 0}, className: 'col-xs-5', =>
          div className: 'row middle between', =>
            crel MenuButton, buttons: [buttons.EXIT_EDITOR], editor: editor, onClick: handleClick
            h2 'Editor'
      br()
      crel UserDeviceProps, editor: editor
      crel UserDashboardsSection, editor: editor
      crel DashboardProps, editor: editor
      crel BaseWidgetProperties, editor: editor





module.exports = inject('editor', 'modal')(observer(LeftPanel))













