import MobxReactForm from 'mobx-react-form'
import ViewStore from '../stores/viewStore'
import Editor from '../stores/editorStore'
import AppStore from '../stores/AppStore'
import UserDevices from '../stores/UserDevices'
import DashboardStore from '../stores/Dashboard'
import DashboardForm from './Dashboard'
import {toJS, runInAction} from 'mobx'
#import {selectBindings} from './components/Select'


fields =
  selectDevice:
    name: 'selectUserDevice'
    label: 'Select User Device'
    disabled: no
    value: '192.168.1.9'
    options: [
      {value: '', label: 'Select Device'}
    ]
#    bindings: 'userDevice'
#
#
#
#
#userDeviceChange = (field) => (e) =>
#  field.value = e.target.value
#  UserDevices.selectedDeviceId = e.target.value





class SelectUserDevice extends MobxReactForm
#  bindings: ->
#    userDevice: selectBindings({
#        onChange: userDeviceChange
#      })

  onSuccess: (form) ->
    {selectDevice} = form.values()
    console.log AppStore.devices.get(selectDevice)
    Editor.device = UserDevices.devices.get(selectDevice)
    Editor.deviceDashboards.replace(DashboardStore.getDeviceDashboards(selectDevice))
    ViewStore.showEditorPage()
    return


  testDashboard: ->
    runInAction(=>
      dashboards = DashboardStore.getDeviceDashboards('192.168.1.9')
      dashboard =  JSON.parse JSON.stringify toJS(toJS(dashboards[0]))
      DashboardForm.set('default', dashboard)
      DashboardForm.set('value', dashboard)


    )



  onError: (form) ->
    console.log('All form errors', form.errors());
    form.invalidate('This is a generic error message!')




form = new SelectUserDevice({ fields })
export default form
