React = require 'react'
{crel, div, br, text} = require 'teact'
{inject,observer} = require 'mobx-react'
LeftPanel = require('../LeftPanel')
SplitPane = require 'react-split-pane'
Dashboard = require './Dashboard'
DashboardEditor = require '../LeftPanel/DashboardEditor'
WidgetEditor = require '../LeftPanel/WidgetEditor'



class EditorPage extends React.Component
  render: ->
    borderStyle = {height: '100%', width: '100%'}

    {editor} = @props
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
      crel LeftPanel
      crel SplitPane, split: 'horizontal', size: 100, allowResize: no, ->
        crel SplitPane, split: 'vertical', size: 250, allowResize: no, ->
          div style: borderStyle
          crel SplitPane, split: 'vertical', size: 250, allowResize: no, ->
            div style: borderStyle, ->
              div style: {padding: 10}, ->
                crel DashboardEditor, editor: editor
            div style: borderStyle
        div ->
          crel SplitPane, split: 'vertical', size: 250, allowResize: no, ->
            div style: borderStyle, ->
              div style: {padding: 10}, ->
                crel WidgetEditor, editor: editor
            div style: {padding: 10}, ->
              if editor.selectedDashboardId is '0'
                return null
              else
                crel Dashboard
            div style: borderStyle



#module.exports = inject('editor')(observer(EditorPage))
export default inject('editor')(observer(EditorPage))


#
#class EditorPage extends React.Component
#  render: ->
#    borderStyle = {height: '100%', width: '100%', backgroundColor: 'black'}
#
#    {editor} = @props
#    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
#      crel LeftPanel
#      crel SplitPane, split: 'vertical', size: 300, allowResize: no, ->
#        div style: borderStyle
#        crel SplitPane, split: 'vertical', size: 400, allowResize: no, ->
#          crel SplitPane, split: 'horizontal', size: 100, allowResize: no, ->
#            div style: borderStyle
#            crel SplitPane, split: 'horizontal', size: 800, allowResize: no, ->
#              div style: {padding: 10},  ->
#                crel Dashboard
#              div style: borderStyle
#          div style: borderStyle