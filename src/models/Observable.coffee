{getDefaultModelSchema} = require 'serializr'
{extendObservable} = require 'mobx'


class ObservableClass
  constructor: (clazz) ->
    if getDefaultModelSchema(clazz).observables?
      extendObservable @, getDefaultModelSchema(clazz).observables


module.exports = ObservableClass