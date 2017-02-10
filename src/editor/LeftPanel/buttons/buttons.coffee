t = require './types'

module.exports =
  EXIT_EDITOR:
    id: t.EXIT_EDITOR
    iconName: 'arrow-left'
    className: 'pt-large pt-minimal'
    initiallyHidden: no
    hideOnEdit: yes
  EDIT_DASHBOARD:
    id: t.EDIT_DASHBOARD
    iconName: 'edit'
    className: 'pt-large '
    intent: 'PRIMARY'
    loading: no
    initiallyHidden: no
    hideOnEdit: yes
  COPY_DASHBOARD:
    id: t.COPY_DASHBOARD
    iconName: 'duplicate'
    className: 'pt-large pt-fill'
    initiallyHidden: no
    hideOnEdit: yes
  DONE_EDITING:
    id: 'DONE_EDITING'
    className: 'pt-large pt-fill'
    iconName: 'cross align-center'
    intent: 'PRIMARY'
    initiallyHidden: yes
    showOnEdit: yes
  SAVE_DASHBOARD:
    id: 'SAVE_DASHBOARD'
    iconName: 'floppy-disk'
    intent: 'SUCCESS'
    className: 'pt-large'
    initiallyHidden: yes
    disabled: yes
    loading: no
    showOnEdit: yes
  DELETE_DASHBOARD:
    id: 'DELETE_DASHBOARD'
    iconName: 'cross'
    className: 'pt-large pt-fill'
    intent: 'DANGER'
    initiallyHidden: yes


  DISCARD_CHANGES:
    id: 'DISCARD_CHANGES'
    iconName: 'cross'
    className: 'pt-large pt-fill'
    intent: 'DANGER'
    initiallyHidden: yes
    disabled: yes
    showOnEdit: yes
  ADD_NEW_WIDGET:
    id: t.ADD_NEW_WIDGET
    text: 'Add Widget Now'
    iconName: 'add'
    className: 'pt-large pt-fill'
    intent: 'SUCCESS'
    disabled: yes
    enableOnEdit: yes
  INC_BORDER_RADIUS:
    id: t.INC_BORDER_RADIUS
    iconName: 'plus'
    disabled:  yes
    enableOnEdit: yes
  DEC_BORDER_RADIUS:
    id: t.DEC_BORDER_RADIUS
    iconName: 'plus'
    disabled:  yes
    enableOnEdit: yes
  INC_CARD_DEPTH:
    id: t.INC_CARD_DEPTH
    iconName: 'minus'
    disabled:  yes
    enableOnEdit: yes
  DEC_CARD_DEPTH:
    id: t.DEC_CARD_DEPTH
    iconName: 'minus'
    disabled:  yes
    enableOnEdit: yes


