require '../widgets/widgets.scss'
require './style.scss'
React = require 'react'
{crel, div, text} = require 'teact'
Dashboard = require './views/Dashboard'



class App extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    @props.deviceStore.subscribe()

  render: ->
    mainStyle =
      height: '100vh'
      width: '100%'
    crel 'div', style: mainStyle, ->
      crel Dashboard, @props




module.exports = App