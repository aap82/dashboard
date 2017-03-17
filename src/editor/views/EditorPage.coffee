React = require 'react'
{crel, div, text} = require 'teact'
{inject,observer} = require 'mobx-react'
LeftPanel = require('../LeftPanel')
SplitPane = require 'react-split-pane'
Dashboard = require './Dashboard'




class EditorPage extends React.Component
  render: ->
    borderStyle = {height: '100%', width: '100%'}

    {editor} = @props
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
      crel LeftPanel
      crel SplitPane, split: 'vertical', size: 300, allowResize: no, ->
        div style: borderStyle
        div ->
          crel SplitPane, split: 'horizontal', size: 100, allowResize: no, ->
            div style: borderStyle
            div style: {padding: 10}, ->
              crel Dashboard
            div style: borderStyle

EditorPage.displayName = 'EditorPage'


module.exports = inject('editor')(observer(EditorPage))



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