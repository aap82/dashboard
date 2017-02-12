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
    hideOnDirty: yes
    initiallyHidden: yes
    showOnEdit: yes
  SAVE_DASHBOARD:
    id: t.SAVE_DASHBOARD
    iconName: 'floppy-disk'
    intent: 'SUCCESS'
    className: 'pt-large'
    initiallyHidden: yes
    disabled: yes
    loading: no
    showOnEdit: yes
    enableOnDirty: yes
  DELETE_DASHBOARD:
    id: t.DELETE_DASHBOARD
    iconName: 'trash'
    className: 'pt-large pt-fill'
    intent: 'DANGER'
    initiallyHidden: yes
    disabled: no
    showOnEdit: yes
    disableOnDirty: yes
  DISCARD_CHANGES:
    id: t.DISCARD_CHANGES
    iconName: 'refresh'
    className: 'pt-large pt-fill'
    intent: 'DANGER'
    initiallyHidden: yes
    disabled: no
    showOnDirty: yes
    showOnEdit: no
  ADD_NEW_WIDGET:
    id: t.ADD_NEW_WIDGET
    text: 'Add Widget'
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
    iconName: 'minus'
    disabled:  yes
    enableOnEdit: yes
  INC_CARD_DEPTH:
    id: t.INC_CARD_DEPTH
    iconName: 'plus'
    disabled:  yes
    enableOnEdit: yes
  DEC_CARD_DEPTH:
    id: t.DEC_CARD_DEPTH
    iconName: 'minus'
    disabled:  yes
    enableOnEdit: yes


