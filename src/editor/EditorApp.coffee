React = require 'react'

{inject, observer} = require 'mobx-react'
{crel} = require 'teact'
EditorPage = require './views/EditorPage'
SetupPage = require './views/SetupPage'



class EditorApp extends React.Component
  render: ->
    {viewStore} = @props
    switch viewStore.currentPageView
      when 'SetupPage' then return crel SetupPage
      when 'EditorPage' then return crel EditorPage




module.exports = observer(EditorApp)