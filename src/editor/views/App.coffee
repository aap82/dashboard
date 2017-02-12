DialogComponentContainer = require '../components/DialogComponent'
{inject, observer} = require 'mobx-react'
{crel, div} = require 'teact'
EditorPage = require './EditorPage'
SetupPage = require './SetupPage'

App = observer(({viewState}) ->
  div ->
    crel DialogComponentContainer
    switch viewState.visiblePage
      when 'setup' then return crel SetupPage
      when 'editor' then return crel EditorPage

)

App.displayName = 'App'
module.exports = inject('viewStore', 'viewState')(App)