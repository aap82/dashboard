import React from 'react'
import {crel, div, br, text} from 'teact'
import {inject,observer} from 'mobx-react'
import LeftPanel from '../LeftPanel'
import SplitPane from 'react-split-pane'
import Dashboard from './Dashboard'
import DashboardEditor from '../LeftPanel/DashboardEditor'
import WidgetEditor from '../LeftPanel/WidgetEditor'


class EditorPage extends React.Component
  render: ->
    column2 = 350
    borderStyle = {height: '100%', width: '100%', backgroundColor: '#293742', color: 'white' }
    {editor} = @props
    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
      crel LeftPanel
      crel SplitPane, split: 'horizontal', size: 150, allowResize: no, ->
        crel SplitPane, split: 'vertical', size: column2, allowResize: no, ->
          div style: borderStyle, ->
            crel DashboardEditor, editor: editor
          crel SplitPane, split: 'vertical', size: editor.dashboard.width + 20, allowResize: no, ->
            div style: borderStyle
            div style: borderStyle
        div ->
          crel SplitPane, split: 'vertical', size: column2, allowResize: no, ->
            div style: borderStyle, ->
              div style: {padding: 10}, ->
                crel WidgetEditor, editor: editor
            crel SplitPane, split: 'vertical', size: editor.dashboard.width + 20, allowResize: no, ->
              div ->
                crel SplitPane, split: 'horizontal', size: editor.dashboard.height + 20, allowResize: no, ->
                  div style: {padding: 10}, ->
                    if editor.selectedDashboardId is '0'
                      div style: borderStyle
                    else
                      crel Dashboard
                  div style: borderStyle
              div style: borderStyle



#export default inject('editor')(observer(EditorPage))

EditorPage = inject('editor')(observer(EditorPage))
export default EditorPage


#
#class EditorPage extends React.Component
#  render: ->
#    borderStyle = {height: '100%', width: '100%', backgroundColor: 'black'}
#
#    {editor} = @props
#    crel SplitPane, split: 'vertical', size: 350, allowResize: no, ->
#      crel LeftPanel
#      crel SplitPane, split: 'vertical', size: 300, allowResize: no, ->
#        div style: borderStyle
#        crel SplitPane, split: 'vertical', size: 400, allowResize: no, ->
#          crel SplitPane, split: 'horizontal', size: 100, allowResize: no, ->
#            div style: borderStyle
#            crel SplitPane, split: 'horizontal', size: 800, allowResize: no, ->
#              div style: {padding: 10},  ->
#                crel Dashboard
#              div style: borderStyle
#          div style: borderStyle