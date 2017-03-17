{DashboardTC, UserDeviceTC} = require '../models'

module.exports =
  createDashboard: DashboardTC.getResolver('createOne')
  updateDashboard: DashboardTC.getResolver('updateOne')
  deleteDashboard: DashboardTC.getResolver('removeOne')
  addUserDevice: UserDeviceTC.getResolver('createOne')
  updateUserDevice: UserDeviceTC.getResolver('updateOne')
  updateUserDeviceById: UserDeviceTC.getResolver('updateById')
