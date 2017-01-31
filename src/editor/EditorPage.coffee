{crel, div, text} = require 'teact'
React = require 'react'
LeftPanel = require('./LeftPanel')
SplitPane = require 'react-split-pane'
Dashboard = require './Dashboard'
DialogComponentContainer = require './components/DialogComponent'
{inject} = require 'mobx-react'





EditorPage = (props) =>
  div ->
    crel DialogComponentContainer, props
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, =>
      crel LeftPanel
      crel Dashboard, props





module.exports = inject('editor', 'dashboard')(EditorPage)