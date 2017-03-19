React = require 'react'
ReactDOM = require 'react-dom';
{crel, div, br, text} = require 'teact'
{extendObservable, action,runInAction} = require 'mobx'
{observer} = require 'mobx-react'
gqlFetch = require('../utils/fetch')('/graphql')


state = JSON.parse(window.__APP_STATE__)
console.log state


style =
  main:
    height: '100%'
    width: '100%'
    backgroundColor: '#2b2b2b'
    color: 'white'
    fontSize: 25
  center:
    position: 'fixed'
    display: 'flex'
    flexDirection: 'column'
    alignItems: 'center'
    top: '50%'
    left: '50%'
    transform: 'translate(-50%, -60%)'
    width: '100%'

  dataRow:
    display: 'flex'
    flexDirection: 'row'
    justifyContent: 'space-between'
    textAlign: 'center'
    marginBottom: 10
    width: 250
    maxWidth: 250



  button:
    display: 'flex'
    flexDirection: 'row'
    textAlign: 'center'
    alignItems: 'center'
    justifyContent: 'center'
    alignSelf: 'center'
    fontWeight: 600
    height: 40
    marginTop: 25
    paddingTop: 10
    paddingBottom: 10
    paddingLeft: 20
    paddingRight: 20
    width: 200





class RegisterDevice extends React.Component
  constructor: (props) ->
    super(props)
    {device} = props
    if !device.registered?
      device.height = '100vh'


    extendObservable @, {
      displayUpdated: no
      fullScreen: no
      device: device
      display:
        height: 0
        width: 0

      setCurrentDisplay: action(=>
        runInAction(=>
          @display.height = window.outerHeight
          @display.width = window.outerWidth
          @displayUpdated = yes
        )
      )


      enterFullScreen: action(=>
        document.documentElement.webkitRequestFullscreen()
        @displayUpdated = no
        @fullScreen = yes
      )
      exitFullScreen: action(=>
        @displayUpdated = no
        document.webkitExitFullscreen()
        @fullScreen = no
      )

      updateUserDevice: action(=>
        @device.height = window.outerHeight
        @device.width = window.outerWidth
        runInAction(=>
          @device.registered = yes
          if @fullScreen then gqlFetch('opName', 'UpdateUserDevice', {ip: @device.ip, device: @device}).then(@handleUpdate)
        )
      )

      handleUpdate: action((result) =>
        runInAction(=>
          @fullScreen = no
          document.webkitExitFullscreen()
          @device.height = result.data.updateUserDevice.record.height
          @device.width = result.data.updateUserDevice.record.width
        )

      )





    }



  componentDidMount: => @setCurrentDisplay()

  render: ->
    mainStyle =
      height: if @device.height? then @device.height + 100 else '100vh'
      width: '100%'
      backgroundColor: '#2b2b2b'
      color: 'white'
      fontSize: 16

    div style: mainStyle, =>
      div style: style.center, =>
        div style: style.dataRow, =>
          div 'Name:'
          div  @device.name
        div style: style.dataRow, =>
          div 'IP Address:'
          div  @device.ip

        div style: style.dataRow, =>
          div 'Display Height:'
          div  if @device.height? then @device.height + 'px' else '' + 'px'
        div style: style.dataRow, =>
          div 'Display Width:'
          div  if @device.width? then @device.width + 'px' else '' + 'px'
        div style: style.dataRow, =>
          div 'Registered?:'
          if @device.registered
            div style: {color: 'green'}, "Yes"
          else
            div style: {color: 'red'}, "No"


        if !@fullScreen
          div style: style.button, className:  'z-depth-3', onClick: @enterFullScreen, "Enter Full Screen"
          div style: style.button, className:  'z-depth-3', onClick: @updateUserDevice, "Register"
          div style: style.button, className:  'z-depth-3', onClick: @setCurrentDisplay, "Update Display Props"
        else
          div style: style.button, className:  'z-depth-3', onClick: @exitFullScreen, "Exit Full Screen"
          if @displayUpdated
            div style: style.button, className:  'z-depth-3', onClick: @updateUserDevice, "Register"
          else
            div style: style.button, className:  'z-depth-0', ->
              div style: {color: '#2b2b2b'}, "Register"

          div style: style.button, className:  'z-depth-3', onClick: @setCurrentDisplay, "Update Display Props"


        br()
        br()
        div style: style.dataRow, =>
          div 'Current Display Height:'
          div  @display.height + 'px'
        div style: style.dataRow, =>
          div 'Current Display Width:'
          div  @display.width + 'px'





RegisterDevice = observer(RegisterDevice)


ReactDOM.render(crel(RegisterDevice, {device: state}), document.getElementById('app'))





