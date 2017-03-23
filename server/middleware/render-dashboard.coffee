async = require('asyncawait/async')
await = require('asyncawait/await')
{renderToString} = require 'react-dom/server'
{crel} = require 'teact'

{observable} = require 'mobx'
{Provider, useStaticRendering} = require 'mobx-react'
useStaticRendering(yes)

device_states = observable.map({})

App = require('../app/dashboard').default

render = async (dashboard, deviceStates) ->
  crel Provider,
    dashboard: dashboard
    deviceStore:
      states: deviceStates
    , ->
      crel App

exports.render_dashboard = ->
  async (ctx, next) ->
    console.log ctx.cacheControl
    {dashboard, deviceStates} = ctx.state.store
    el = await render(dashboard, device_states.replace(deviceStates))
    ctx.state.html = await renderToString(el)
    await next()





