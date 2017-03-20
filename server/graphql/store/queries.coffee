{DashboardEditorFields, DashboardFields} = require('../models/Dashboard').fields
{DevicesQueryFields} = require '../types/devices'
{UserDeviceFields} = require('../models/UserDevice')
q = {}


q.getDashboardsAndDevices = "
  query getDashboardsAndDevices {
    dashboards {
       #{DashboardEditorFields}
  }
    devicesSetup {
      #{DevicesQueryFields}
    }
    deviceStates {
      states
    }
    devicePlatforms {
      platforms
    }
    userDevices {
      ip
      type
      name
      location
      defaultDashboardId
      height
      width
    }

  }
"

q.getDeviceStatesAll = "
  query getDeviceStatesAll {
    deviceStates {
      states
    }

  }
"

q.GetUserDeviceAndDashboard = "
  query GetUserDeviceAndDashboard($ip: String) {
    userDevice(filter: {ip: $ip}) {
      ip
      type
      name
      location
      height
      width
      defaultDashboardId
      dashboards {
        #{DashboardFields}
      }
    }
  }
"

q.getUserDevice = "
  query GetUserDevice($ip: String) {
      userDevice(filter: {ip: $ip}) { #{UserDeviceFields}}
  }

"

q.GetUserDashboardSetup = "
  query GetUserDashboardSetup($ip: String) {
    userDevice(filter: {ip: $ip}) {
      ip
      dashboards {
        _id
        uuid
        title
      }
    }
  }

"

q.getDashboardDeviceStates = "
  query GetDashboardDeviceStates($devices: [String]) {
    dashboardDeviceStates(devices: $devices)
  }

"


q.getRegisteredDevices = "
  query AllDeviceIPs {
    userDevices {
      ip
    }
  }

"


module.exports = q