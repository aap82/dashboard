{extendObservable, action, computed} = require 'mobx'
{Intent} = require('@blueprintjs/core')

class Button
  constructor: (editor, button, onClick) ->
    @id = button.id
    @text = button.text or ''
    @className = button.className or ''
    @enableOnEdit = button.enableOnEdit or no
    @showOnDirty = button.showOnDirty or no
    @hideOnDirty = button.hideOnDirty or no
    @showOnEdit = button.showOnEdit or no
    @hideOnEdit = button.hideOnEdit or no
    @enableOnDirty = button.enableOnDirty or no
    @disableOnDirty = button.disableOnDirty or no
    @intent = switch button.intent?
      when no then Intent.NONE
      else switch button.intent
        when "PRIMARY" then Intent.PRIMARY
        when "SUCCESS" then Intent.SUCCESS
        when "DANGER" then Intent.DANGER
        when "WARNING" then Intent.WARNING
        else  Intent.NONE
    extendObservable @, {
      iconName: button.iconName or ''
      loading: button.loading or no
      isVisible: computed(->
        if editor.isDirty and @showOnDirty then yes
        else if editor.isDirty and @hideOnDirty then no
        else if editor.isEditing and @hideOnEdit then no
        else if editor.isEditing and @showOnEdit then yes
        else if !!button.initiallyHidden
          no
        else
          yes

      )
      disabled: computed(->
        if editor.isDirty and @enableOnDirty then no
        else if editor.isDirty and @disableOnDirty then yes
        else if editor.isEditing and @enableOnEdit then no
        else
          button.disabled
      )

    }


module.exports = Button