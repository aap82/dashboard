import gridFields from './grid'

fields =
  title:
    name: 'title'
    label: 'Title'
    value: ''
    className: ''
    placeholder: 'New Dashboard'
    type: 'text'
    rules: 'alpha_dash|required'
    bindings: 'defaultBinding'
  orientation:
    name: 'orientation'
    label: 'Device Orientation'
    value: 'portrait'
    options: [
      {value: 'portrait', label: 'Portrait'}
      {value: 'landscape', label: 'Landscape'}
    ]
    bindings: 'defaultBinding'
  grid: gridFields






export default fields