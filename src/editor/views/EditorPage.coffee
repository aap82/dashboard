React = require 'react'
{crel, div, text} = require 'teact'
{observer} = require 'mobx-react'
LeftPanel = require('../LeftPanel')
SplitPane = require 'react-split-pane'
Dashboard = require './Dashboard'




class EditorPage extends React.Component
  render: ->
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
      crel LeftPanel
      crel Dashboard

EditorPage.displayName = 'EditorPage'


module.exports = observer(EditorPage)