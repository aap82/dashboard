import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import Container from './Container'


Dashboard = observer(({editor, borderStyle}) ->
  switch editor.device
    when null
      div style: {height: '100%', width: '100%', backgroundColor: '#293742', color: 'white' }
    else
      crel Container, borderStyle: borderStyle
)

Dashboard = inject('editor')(Dashboard)
export default Dashboard

