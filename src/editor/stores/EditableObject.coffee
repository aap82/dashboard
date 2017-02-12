{extendObservable, action, isObservableArray, toJS, computed} = require 'mobx'

{createViewModel} = require('mobx-utils')



DashboardModel = (id, title, deviceType) ->
  @id = id
  extendObservable @, {
    title:  title
    deviceType: deviceType
    cols:  if deviceType is 'phone' then 80 else 155
    marginX:  0
    marginY:  0
    rowHeight: 5
    backgroundColor:  "#ff525b"
    widgets:  []
    layouts:  []
    devices:  []
    style:
      position: 'relative'
      height: '100%'
      width:  if deviceType is 'phone' then 500 else 1200
      backgroundColor: '#be682e'
      color: 'white'
    widgetProps:
      backgroundColor: "#ff525b"
      backgroundAlpha: 100
      color: "#fff"
      borderRadius: 2
      cardDepth: 2
  }

class Editable
  constructor:  ->
    cleanModel = new DashboardModel
    @viewModel = createViewModel(cleanModel)
    extendObservable(@, {
      isEditing: no
      setProp: action((prop, value) ->
        switch prop
#          when isObservableArray(@["#{prop}"]) then  @["#{prop}"].replace(value)
          when isObservableArray(@viewModel[prop]) then @viewModel[prop].replace(value)
          else
#            @["#{prop}"] = value if @["#{prop}"]?
            @viewModel[prop] = value if @viewModel[prop]

      )
      setProps: action((props) -> @setProp(key, value) for key, value of props)
      setStyleProp: action((prop, value) ->


        console.log @viewModel.style
        @viewModel.style[prop] = value

        @viewModel.submit()
        console.log @viewModel.isPropertyDirty('style')
#        @style["#{prop}"] = value
      )
      setLayout: action(-> @layouts.replace(@newLayout))
      setWidgetProp: action((prop, value) ->

        console.log @viewModel.model.widgetProps[prop]
        console.log value
        @viewModel.widgetProps[prop] = JSON.parse(JSON.stringify(value))
        console.log @viewModel.model.widgetProps[prop]
        console.log @viewModel.isDirty
        console.log 'xxxxxxxxxxxxxx'
#        @widgetProps["#{prop}"] = value
      )
    })

  initDashboard: (id = -1, title='Dashboard Title', deviceType='tablet') ->
    @viewModel.id = id
    @viewModel.title = title
    @viewModel.deviceType = deviceType
    @viewModel.submit()
    return


  resetModel: ->
    @viewModel.reset()





module.exports = Editable