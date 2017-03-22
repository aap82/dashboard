import {extendObservable, computed} from 'mobx'
import {Intent} from '@blueprintjs/core'

class Button
  constructor: (editor, button) ->
    enableOnEdit = button.enableOnEdit ? no
    disableOnEdit = button.disableOnEdit ? no
    showOnDirty = button.showOnDirty ? no
    hideOnDirty = button.hideOnDirty ? no
    showOnEdit = button.showOnEdit ? no
    hideOnEdit = button.hideOnEdit ? no
    enableOnDirty = button.enableOnDirty ? no
    disableOnDirty = button.disableOnDirty ? no
    initiallyDisabled = button.disabled ? no


    @id = button.id
    @text = button.text ? ''
    @className = button.className ? ''
    @intent = switch button.intent?
      when no then Intent.NONE
      else switch button.intent
        when "PRIMARY" then Intent.PRIMARY
        when "SUCCESS" then Intent.SUCCESS
        when "DANGER" then Intent.DANGER
        when "WARNING" then Intent.WARNING
        else  Intent.NONE
    extendObservable @, {
      iconName: button.iconName ? ''
      loading: button.loading ? no
      isVisible: computed(->
        if editor.isDirty and showOnDirty then yes
        else if editor.isDirty and hideOnDirty then no
        else if editor.isEditing and hideOnEdit then no
        else if editor.isEditing and showOnEdit then yes
        else if !!button.initiallyHidden
          no
        else
          yes

      )
      disabled: computed(->
        if editor.selectedDashboardId is '0' then yes
        else if editor.isDirty and enableOnDirty then no
        else if editor.isDirty and disableOnDirty then yes
        else if editor.isEditing and enableOnEdit then no
        else if editor.isEditing and disableOnEdit then yes
        else
          initiallyDisabled
      )

    }


export default Button