import ToolBar from './ToolBar'
export default ToolBar


#
#DeviceOrientation = observer(class DeviceOrientation extends React.Component
#  handleChange: (e) =>
#    {device} = @props
#    device.settings.grid.orientation = e.target.value
#  render: ->
#    {device} = @props
#    {grid} = device.settings
#
#    div className: 'pt-select pt-fill', =>
#      select onChange: @handleChange, value: grid.orientation, =>
#        option key: 'portrait', value: 'portrait', "Portrait"
#        option key: 'landscape', value: 'landscape', "Landscape"
#
#)