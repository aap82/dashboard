{DashboardSetupFields} = require '../types/dashboard'
{DevicesQueryFields} = require '../types/devices'
q = {}


q.getDashboardsAndDevices = "
  query getDashboardsAndDevices {
    dashboards {
       #{DashboardSetupFields}
  }
    devices {
      #{DevicesQueryFields}
    }

  }
"



module.exports = q