async = require('asyncawait/async')
await = require('asyncawait/await')
{renderToString} = require 'react-dom/server'
{crel} = require 'teact'

{observable} = require 'mobx'
{Provider, useStaticRendering} = require 'mobx-react'
useStaticRendering(yes)

device_states = observable.map({})


DeviceStore = require '../store'


App = require('../app/dashboard').default

renderDashboard = async ({dashboard, deviceStates}) ->
  crel Provider,
    dashboard: dashboard
    deviceStore:
      states: deviceStates
    , ->
      crel App

module.exports = ->
  async (ctx, next) ->
    states = await DeviceStore.getStatesObj(ctx.state.store.dashboard.devices)
    ctx.state.store.deviceStates = device_states.replace(states)
    el = await renderDashboard(ctx.state.store)
    ctx.state.html = await renderToString(el)

    await next()





