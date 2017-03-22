import React from 'react';
import { FocusStyleManager } from  '@blueprintjs/core';
import ReactDOM from 'react-dom';
import { AppContainer } from 'react-hot-loader';
import {configureStores} from './store';
import gqlFetch from '../utils/fetch'
import App from './devEntry';
import {Provider, useStaticRendering} from 'mobx-react'
FocusStyleManager.onlyShowFocusOnTabs()
import { configureDevtool } from 'mobx-react-devtools'




configureDevtool({
  logEnabled: false,
  updatesEnabled: false,
  // logFilter: change => change.type !== 'reaction'
})
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