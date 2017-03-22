import React from 'react'
import {div, crel, a, h5} from 'teact'
import {observer} from 'mobx-react'
import WidgetStyle from './WidgetStyleEditor'
import {Switch} from  '@blueprintjs/core'
keys =
  CTRL: 17
  ESC: 27
  LEFT: 37
  UP: 38
  RIGHT: 39
  DOWN: 40

class GroupStyleOverrideSwitch extends React.Component
  toggleGroupStyleOverrides: (e) =>
    {editor} = @props
    {checked} = @refs.switch.props
    for widget, i in editor.editingWidgets
      widget.overrideStyle = !checked



  render: ->
    {editor} = @props
    overrides = (widget.overrideStyle for widget in editor.editingWidgets when widget.overrideStyle)
    div style: {marginBottom:  0}, className: 'row between middle', =>
      div style: {width: '100%'}, =>
        crel Switch,
          ref: 'switch'
          label: 'Override Global Style?'
          className: 'pt-fill pt-align-right'
          checked: overrides.length is editor.editingWidgets.length
          onChange: @toggleGroupStyleOverrides

GroupStyleOverrideSwitch = observer(GroupStyleOverrideSwitch)




DistributionButtons = observer(({editor, onClick}) ->
  isDisabled = {}
  for layout in editor.editingLayouts
    console.log layout

  div className: 'pt-button-group pt-fill', onClick: onClick, =>
    a id: 'horizontally', className: 'pt-button', role: 'button', 'Horizontally'
    a id: 'vertically',  className: 'pt-button', role: 'button', 'Vertically'


)



class GroupWidgetEditor extends React.Component
  constructor: (props) ->


  topAlign = (editor) =>
    minY = editor.editingLayouts[0].y
    for layout in editor.editingLayouts
      console.log layout.y
      if layout.y < minY then minY = layout.y

    for layout in editor.editingLayouts
      layout.y = minY
    editor.updateDashboard()


  handleAlignmentClick: (e) =>
    console.log e.target.id
    {editor} = @props
    switch e.target.id
      when 'top'
        topAlign(editor)
        break


  handleKeyDown: (e) =>
    {editor, layout} = @props
    if e.keyCode is keys.ESC
      editor.editingWidgets.clear()
      editor.editingLayouts.clear()


  componentDidMount: ->
    console.log 'group mount'
    document.addEventListener('keydown', @handleKeyDown)
  componentWillUnmount: ->
    console.log 'group unmount'
    document.removeEventListener('keydown', @handleKeyDown)


  render: ->
    {editor, widgets, layouts} = @props
    div style: {paddingTop: 10}, =>
      div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 5}, className: 'row center middle', =>
        h5 'Group Widget Properties'
      div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 5}, className: 'row between middle', =>
        div 'Total Widgets'
        div editor.dashboard.layouts.length
      div style: {paddingLeft: 5, paddingRight: 5, marginBottom: 15}, className: 'row between middle', =>
        div 'Selected Widgets'
        div editor.editingWidgets.length
      div style: {marginBottom: 5}, className: 'row center middle', =>
        div style: fontWeight: 500, 'Alignment'
      div style: {marginBottom: 25}, className: 'row center middle', =>
        div style: {width: '100%'}, =>
          div className: 'pt-button-group pt-fill', onClick: @handleAlignmentClick, =>
            a id: 'left', className: 'pt-button', role: 'button', 'Left'
            a id: 'right',  className: 'pt-button', role: 'button', 'Right'
            a id: 'top',  className: 'pt-button',  role: 'button',  'Top'
            a id: 'bottom',  className: 'pt-button',  role: 'button', 'Bottom'
      div style: {marginBottom: 5}, className: 'row center middle', =>
        div style: fontWeight: 500, 'Distribution'
      div style: {marginBottom: 20}, className: 'row center middle', =>
        div style: {width: '100%'}, =>
          div className: 'pt-button-group pt-fill', onClick: @handleAlignmentClick, =>
            a id: 'horizontally', className: 'pt-button', role: 'button', 'Horizontally'
            a id: 'vertically',  className: 'pt-button', role: 'button', 'Vertically'
      crel GroupStyleOverrideSwitch,
        editor: editor
      crel WidgetStyle, editor: editor





export default observer(GroupWidgetEditor)
