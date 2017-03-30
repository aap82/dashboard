import SwitchWidget from './SwitchWidget'
import ButtonWidget from './ButtonWidget'




export getWidget = (type) =>
  switch type
    when 'switchWidget' then return SwitchWidget
    when 'buttonWidget'then return ButtonWidget
    else null

