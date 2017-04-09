import {crel, div} from 'teact'
import {inject, observer} from 'mobx-react'
import {Dialog} from '@blueprintjs/core'

DialogComponentContainer = observer(({modal}) =>
  crel Dialog,
    className: 'pt-dark'
    lazy: yes
    style: modal.style
    isCloseButtonShown: no
    canEscapeKeyClose: if modal.forceClose then no else yes
    canOutsideClickClose: if modal.forceClose then no else yes
    transitionDuration: 150
    onClose: (-> modal.close() if modal.forceClose )
    title: modal.title
    iconName: modal.iconName
    isOpen: modal.isOpen, ->
      div 'pt-dialog-body', ->
        modal.component


)

export default inject('modal')(DialogComponentContainer)

