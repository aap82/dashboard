require '../widgets/widgets.scss'
require './style.scss'
React = require 'react'
{crel, div, text} = require 'teact'
Dashboard = require './views/Dashboard'



export default class App extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    @props.deviceStore.subscribe()

  render: ->
    mainStyle =
      height: '100%'
      width: '100%'
    crel 'div', style: mainStyle, ->
      crel Dashboard, @props




