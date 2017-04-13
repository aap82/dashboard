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
    bindings: 'dashboard'
  cols:
    name: 'col'
    label: 'Columns'
    value: 600
    rules: 'required|integer|min:3'

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
    value: 5
    rules: 'required|integer|min:1'

  backgroundColor:
    name: 'backgroundColor'
    label: 'Background Color'
    value: '#211f1f'

  widgetBorderRadius:
    label: 'Widget Border Radius'
    value: 0
    rules: 'required|integer|min:0'

  widgetCardDepth:
    label: 'Widget Card Depth'
    value: 2
    rules: 'required|integer|between:0,5'

  widgetBackgroundColor:
    label: 'Widget Background Color'
    value:  '#be682e'

  widgetBackgroundAlpha:
    label: 'Widget Background Alpha'
    value:  100

  widgetFontColor:
    label: 'Widget Font Color'
    value: '#fff'

  widgetFontSizePrimary:
    label: 'Widget Font Size Primary'
    value: 18

  widgetFontSizeSecondary:
    label: 'Widget Font Size Secondary'
    value: 12

  widgetFontWeightPrimary:
    label: 'Widget Font Weight Primary'
    value: 600

  widgetFontWeightSecondary:
    label: 'Widget Font Weight Secondary'
    value: 500






export default fields