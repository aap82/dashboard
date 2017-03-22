import DialogComponentContainer from '../components/DialogComponent'
import {inject, observer} from 'mobx-react'
import {crel, div} from 'teact'
import EditorPage from './EditorPage'
import SetupPage from './SetupPage'

export default App = inject('viewState')(observer(({viewState}) ->
  displayName: 'App'
  div ->
    crel DialogComponentContainer
    switch viewState.visiblePage
      when 'setup' then return crel SetupPage
      when 'editor' then return crel EditorPage

))
