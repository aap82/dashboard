{DashboardSetupFields} = require '../types/dashboard'
m = {}


m.createDashboard = "
mutation CreateDashboard($dashboard: DashboardInput) {
  create(newDashboard: $dashboard) {
    #{DashboardSetupFields}
  }
}
"



m.updateDashboard = "
mutation UpdateDashboard($id: Int, $dashboard: DashboardInput) {
  update(id: $id, update: $dashboard) {
    #{DashboardSetupFields}
  }
}
"



m.deleteDashboard = "
mutation DeleteDashboard($id: Int) {
  delete(id: $id) {
    id
  }
}
"


module.exports = m



