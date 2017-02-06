React = require 'react'
{crel, div, select, option, br } = require 'teact'
{ observer} = require 'mobx-react'
{ Button} = require('@blueprintjs/core')
DashboardItem = require './DashboardItem'
{DashboardColorPicker} = require './ColorPicker'

DeviceType = (observer(({editor, dashboard, onChange}) ->
  div ->
    div className: 'pt-select', ->
      select onChange: onChange, value: dashboard.deviceType, disabled: !editor.isEditing, ->
        option value: '', ''
        option value: 'tablet', 'Tablet'
        option value: 'phone', 'Phone'

))


class DeviceTypeEditor extends React.Component
  onDeviceTypeChange: (e) => @props.dashboard.setProp('deviceType', e.target.value)
  render: ->
    {dashboard, editor} = @props
    div className: 'row between middle', =>
      crel 'div', 'Device Type'
      crel DeviceType, dashboard: dashboard, editor: editor, onChange: @onDeviceTypeChange


PropertiesSectionTitleButton = ->
  crel Button,
    text: 'Properties'
    iconName: 'caret-down'
    className: 'pt-minimal pt-fill pt-large'



DashboardProperties = (props) ->
  div className: 'properties-section', ->
    div className: 'title-row button', ->
      crel PropertiesSectionTitleButton
    div className: 'content', ->
      crel DeviceTypeEditor, props
      crel DashboardColorPicker, props
      br()





module.exports = DashboardProperties

















#
#
#class GridProps extends React.Component
#  render: ->
#    {dashboard} = @props
#    getProps = (id, title) ->
#      id: id
#      title: title
#      dashboard: dashboard
#    div className: 'grid-props', =>
#      div className: 'column', =>
#        crel DashboardItem, getProps('cols', 'Columns')
#        crel DashboardItem, getProps('rowHeight', 'RowHt')
#      div className: 'column', =>
#        crel DashboardItem, getProps('marginX', 'Margin X')
#        crel DashboardItem, getProps('marginY', 'Margin Y')
