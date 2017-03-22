require('@blueprintjs/core/dist/blueprint.css')
require('./prod_style.scss')
import React from 'react';
import ReactDOM from 'react-dom';
import { FocusStyleManager } from  '@blueprintjs/core';
import {configureStores} from './store';
import gqlFetch from '../utils/fetch'
import App from './views/App';
import {Provider, useStaticRendering} from 'mobx-react'

FocusStyleManager.onlyShowFocusOnTabs()


const state = JSON.parse(window.__APP_STATE__)
const stores = configureStores(state, gqlFetch('/graphql'))
useStaticRendering(false)
ReactDOM.render(
  <Provider {...stores}>
    <App />
  </Provider>,
  document.getElementById('app')
);

