import MobxReactForm from 'mobx-react-form'
import validatorjs from 'validatorjs'
import fields from './fields/dashboard'
import getBindings from './bindings'
plugins = { dvr: validatorjs }
import Editor from '../stores/editorStore'


customChange = (field) => (e) =>
  if Editor.isEditing
    field.value = e.target.value

    if Editor.dashboard[field.key]?
      Editor.dashboard[field.key] = field.value

customBlur = (field) => (e) =>
  console.log 'hi'

class DashboardPropsForm extends MobxReactForm
  bindings: ->
    bindings = getBindings({
      onChange: customChange
      onBlur: customBlur
    })
    bindings

  onChange: (e) ->
    console.log e
  onSuccess: (form) ->
    alert('Form is valid! Send the request here.')
    console.log('Form Values!', form.values())


  onError: (form) ->
    console.log('All form errors', form.errors());
    form.invalidate('This is a generic error message!')





form = new DashboardPropsForm({ fields }, {plugins})
export default form
