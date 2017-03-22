{getDefaultModelSchema} from 'serializr'
{extendObservable} from 'mobx'


class ObservableClass
  constructor: (clazz) ->
    if getDefaultModelSchema(clazz).observables?
      extendObservable @, getDefaultModelSchema(clazz).observables


export default ObservableClass