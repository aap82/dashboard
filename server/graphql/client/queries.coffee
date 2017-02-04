{DashboardSetupFields} = require '../types/dashboard'
{DevicesQueryFields} = require '../types/devices'
q = {}


q.getDashboardsAndDevices = "
  query getDashboardsAndDevices {
    dashboards {
       #{DashboardSetupFields}
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

  }
"

q.getDeviceStatesAll = "
  query getDeviceStatesAll {
    deviceStates {
      states
    }

  }
"



module.exports = q