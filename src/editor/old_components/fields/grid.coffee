import {Intent } from "@blueprintjs/core"

gridFields =
  backgroundColor:
    name: 'backgroundColor'
    label: 'Background Color'
    value:
      color: '#ffffff'
      alpha: 100
      mode: 'HSL'
    bindings: 'defaultBinding'
  cols:
    name: 'cols'
    label: 'Columns'
    value: 300
    rules: 'required|integer|min:8'
    intent: 'PRIMARY'
    className: ''
    min: 1
    max: 100
    minorStepSize: 1
    buttonPosition: 'RIGHT'
    bindings: 'BlueprintNumberInput'
  marginX:
    name: 'marginX'
    label: 'Margin X'
    value: 0
    rules: 'required|integer|min:0'
  marginY:
    name: 'marginY'
    label: 'Margin Y'
    value: 0
    rules: 'required|integer|min:0'
  rowHeight:
    name: 'rowHeight'
    label: 'Row Height'
    value: 1
    intent: 'PRIMARY'
    className: ''
    min: 1
    max: 100
    minorStepSize: 1
    buttonPosition: 'RIGHT'
    rules: 'required|integer|min:1'
    bindings: 'BlueprintNumberInput'




export default gridFields