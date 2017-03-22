t = require './types'

module.exports =
  CREATE_DASHBOARD:
    id: t.CREATE_DASHBOARD
    text: 'Create Dashboard'
    iconName: 'add'
    className: 'pt-large pt-fill'
    intent: 'SUCCESS'
    disabled: yes
    enableOnEdit: yes
  EXIT_EDITOR:
    id: t.EXIT_EDITOR
    iconName: 'arrow-left'
    className: 'pt-large pt-minimal'
    initiallyHidden: no
    disableOnEdit: yes
    disableOnDirty: yes
  EDIT_DASHBOARD:
    id: t.EDIT_DASHBOARD
    iconName: 'edit'
    className: 'pt-fill'
    intent: 'PRIMARY'
    text: 'Start Editing'
    loading: no
    initiallyHidden: no
    hideOnEdit: yes
  COPY_DASHBOARD:
    id: t.COPY_DASHBOARD
    text: 'Copy'
    iconName: 'duplicate'
    className: 'pt-fill'
    initiallyHidden: no
    hideOnEdit: yes
  DONE_EDITING:
    id: 'DONE_EDITING'
    text: 'Done Editing'
    className: 'pt-fill'
    iconName: 'cross align-center'
    intent: 'PRIMARY'
    disableOnDirty: yes
    initiallyHidden: yes
    showOnEdit: yes
    hideOnDirty: yes
  SAVE_DASHBOARD:
    id: t.SAVE_DASHBOARD
    text: 'Save to DB'
    iconName: 'floppy-disk'
    intent: 'SUCCESS'
    className: 'pt-fill'
    initiallyHidden: yes
    disabled: yes
    loading: no
    showOnEdit: yes
    enableOnDirty: yes
    showOnDirty: yes
  DELETE_DASHBOARD:
    id: t.DELETE_DASHBOARD
    text: 'Delete'
    iconName: 'trash'
    className: 'pt-fill'
    intent: 'DANGER'
    initiallyHidden: no
    hideOnEdit: yes
  DISCARD_CHANGES:
    id: t.DISCARD_CHANGES
    text: 'Discard Changes'
    iconName: 'refresh'
    className: 'pt-fill'
    intent: 'DANGER'
    initiallyHidden: yes
    disabled: yes
    loading: no
    showOnEdit: yes
    enableOnDirty: yes
    showOnDirty: yes
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


