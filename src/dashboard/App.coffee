import React from 'react'
require './style.scss'
import {crel, div, text} from 'teact'
import Dashboard from './views/Dashboard'



class App extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    @props.viewStore.init()

  componentWillUnmount: ->
    @props.viewStore.exit()

  render: ->
    crel Dashboard




export default App