import {inject, observer} from 'mobx-react'
import {crel, div} from 'teact'
import FloatingPanel from './Containers/SettingsPanel'
import SettingsPanel from './SettingsPanel'
import MainApp from './Containers/MainApp'



MainContainer = inject('app', 'editor', 'panel')(observer(({
  editor, app, panel, leftPaneWidth, borderStyle
}) ->
  {settings} = editor
  displayName: 'MainContainer'
  switch editor.device
    when null
      div style: borderStyle
    else
      div style: borderStyle, ->
        crel MainApp,
          editor: editor
          settings: settings
          borderStyle: borderStyle
          leftBound: leftPaneWidth
        crel FloatingPanel,
          app: app,
          panel: panel,
          =>
            crel SettingsPanel,
              leftBound: leftPaneWidth,
              app: app,
              panel: panel,
              settings: settings
))

export default MainContainer