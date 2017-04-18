import defaultProps from '../defaultProps'
import {merge} from 'lodash'

switchProps =
  type: 'switch'
  label: ''
  layout:
    w: 90
    h: 90
    minW: 90
    minH: 90
  overrides:
    font: [
      'primary'
    ]

editable = [
  'label'


]

switchProps = merge(defaultProps, switchProps)
console.log switchProps

export default switchProps