require './styles.scss'


{ FocusStyleManager } = require '@blueprintjs/core'
FocusStyleManager.onlyShowFocusOnTabs()
T = require 'teact'
ReactDOM = require 'react-dom'
{Provider, useStaticRendering} = require 'mobx-react'
gqlFetch = require('../utils/fetch')('/graphql')
{configureStores} = require './stores'

EditorApp = require('./views/App')


useStaticRendering(false)



state = JSON.parse(window.__APP_STATE__)
stores = configureStores(state, gqlFetch)

container = document.querySelector('#app')
ReactDOM.render(
  T.crel Provider, stores, =>
    T.crel EditorApp,
  container
)

