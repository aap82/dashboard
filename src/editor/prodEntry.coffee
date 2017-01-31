require './styles.scss'

{crel} = require 'teact'
React = require 'react'
ReactDOM = require 'react-dom'
{Provider, useStaticRendering} = require 'mobx-react'


gqlFetch = require('../utils/fetch')('/graphql')
{configureStores} = require './stores'

state = JSON.parse(window.__APP_STATE__)
stores = configureStores(state, gqlFetch)

useStaticRendering(false)
EditorApp = require './EditorApp'
container = document.querySelector('#app')

ReactDOM.render(
  crel Provider, stores, =>
    crel EditorApp,
  container
)
