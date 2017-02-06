{crel, div, text} = require 'teact'
LeftPanel = require('../LeftPanel')
SplitPane = require 'react-split-pane'
Dashboard = require './Dashboard'
DialogComponentContainer = require '../components/DialogComponent'



module.exports =  ->
  displayName: 'EditorPage'
  div ->
    crel DialogComponentContainer
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, =>
      crel LeftPanel
      crel Dashboard




