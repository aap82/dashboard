import React from 'react';
import ReactDOM from 'react-dom';
import { AppContainer } from 'react-hot-loader';
import {configureStores} from './store';

import App from './App';
import {Provider, useStaticRendering} from 'mobx-react'

const state = JSON.parse(window.__APP_STATE__)
const stores = configureStores(state)

useStaticRendering(false)
const render = (Component) => {
  ReactDOM.render(
    <AppContainer>
      <Provider {...stores}>
        <Component {...stores} />
      </Provider>
    </AppContainer>,
    document.getElementById('app')
  );
};

render(App);

// Hot Module Replacement API
if (module.hot) {
  module.hot.accept('./App', () => {
    render(App)
  });
}