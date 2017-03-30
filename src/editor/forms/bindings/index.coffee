{dashboard} = require './dashboard'
{defaultBinding} = require './default'

bindings = (overrides = {}) ->
  defaultBinding: defaultBinding()

  dashboard: dashboard(overrides)

export default bindings