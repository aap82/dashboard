{extendObservable} = require 'mobx'

class EditableStore

  isEditing: no


  constructor: (obj) ->
