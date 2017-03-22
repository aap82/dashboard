import React from 'react';
import ReactDOM from 'react-dom';
import {configureStores} from './store';
import App from './App';
import {Provider, useStaticRendering} from 'mobx-react'
const state = JSON.parse(window.__APP_STATE__)
const stores = configureStores(state)

useStaticRendering(false)

ReactDOM.render(
  <Provider {...stores}>
    <App {...stores}/>
  </Provider>
  ,document.getElementById('app')
);

