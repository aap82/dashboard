import React from 'react';
import ReactDOM from 'react-dom';
import { AppContainer } from 'react-hot-loader';
import {configureStores} from './stores';
import gqlFetch from '../utils/fetch'
import App from './devEntry';
import {Provider, useStaticRendering} from 'mobx-react'

const state = JSON.parse(window.__APP_STATE__)
const stores = configureStores(state, gqlFetch('/graphql'))
useStaticRendering(false)
const render = (Component) => {
  ReactDOM.render(
    <AppContainer>
      <Provider {...stores}>
        <Component />
      </Provider>
    </AppContainer>,
    document.getElementById('app')
  );
};

render(App);

// Hot Module Replacement API
if (module.hot) {
  module.hot.accept('./devEntry', () => {
    render(App)
  });
}