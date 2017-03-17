{DashboardEditorFields, DashboardFields} = require('../models/Dashboard').fields
{UserDeviceFields} = require('../models/UserDevice')
m = {}

m.createDashboard = "
mutation CreateDashboard($dashboard:  CreateOneDashboardInput!) {
  createDashboard(record: $dashboard) {
    recordId
  }
}
"



m.updateDashboard = "
mutation UpdateDashboard($uuid: String, $dashboard: UpdateOneDashboardInput!) {
  updateDashboard(record: $dashboard, filter: {uuid: $uuid}) {
    recordId
  }
}
"



m.deleteDashboard = "
mutation DeleteDashboard($uuid: String) {
  deleteDashboard(filter: {uuid: $uuid}) {
    recordId
  }
}
"


m.createUserDevice = "
mutation AddUserDevice($device:  CreateOneUserDeviceInput!) {
  addUserDevice(record: $device) {
    record {#{UserDeviceFields}}
  }
}
"

m.updateUserDevice = "
mutation UpdateUserDevice($ip: String, $device:   UpdateOneUserDeviceInput!) {
  updateUserDevice(record: $device,filter: {ip: $ip}) {
    record {#{UserDeviceFields}}
  }
}
"




m.setDefaultDashboard = "
mutation SetDefaultDashboard($ip: String, $height: Float, $width: Float, $uuid: String) {
  updateUserDevice(record: {defaultDashboardId: $uuid, height: $height, width: $width}, filter: {ip: $ip}) {
    recordId

}
}
"

module.exports = m



