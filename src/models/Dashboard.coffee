class DashboardModel
  @create: (title, deviceType) ->
    title:  title or 'Dashboard Title'
    deviceType:  deviceType or 'tablet'
    cols:  if @deviceType is 'phone' then 80 else 155
    marginX:  0
    marginY:  0
    rowHeight: 5
    widgets:  []
    layouts:  []
    devices:  []
    style: 
      position: 'relative'
      height: '100%'
      width:  if @deviceType is 'phone' then 500 else 1200
      backgroundColor: '#be682e'
      color: 'white'


module.exports = DashboardModel