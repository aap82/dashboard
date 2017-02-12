{extendObservable, action} = require 'mobx'
{Intent} = require('@blueprintjs/core')

class Button
  constructor: (button, onClick) ->
    @id = button.id
    @text = button.text or ''
    @className = button.className or ''
    @onClick = onClick
    @enableOnEdit = button.enableOnEdit or no
    @showOnEdit = button.showOnEdit or no
    @hideOnEdit = button.hideOnEdit or no
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
      disabled: button.disabled or no
      display: ''

      show: action(=> @display = '')
      hide: action(=> @display = 'hidden')
      enable: action(=> @disabled = no)
      disable: action(=> @disabled = yes)
    }
    if !!button.initiallyHidden then @hide()


module.exports = Button