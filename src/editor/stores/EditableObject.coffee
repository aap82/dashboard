{extendObservable, action, isObservableArray, toJS, observable} = require 'mobx'

class Editable
  constructor:  ->
    extendObservable(@, {
      isEditing: no
      setProp: action((prop, value) ->
        switch prop
          when isObservableArray(@["#{prop}"]) then  @["#{prop}"].replace(value)
          else
            @["#{prop}"] = value if @["#{prop}"]?
      )
      setProps: action((props) -> @setProp(key, value) for key, value of props)
      setStyleProp: action((prop, value) -> @style["#{prop}"] = value )
      startEditing: action(->
        console.log @
        @isEditing = yes)
      stopEditing: action(->
        console.log @
        @isEditing = no)
      setLayout: action(-> @layouts.replace(@newLayout))
      setWidgetEditorProp: action((prop, value) -> @widgetProps["#{prop}"] = value)
    })

module.exports = Editable