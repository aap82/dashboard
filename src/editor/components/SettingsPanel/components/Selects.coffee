import React from 'react'
import {div, select, option, text} from 'teact'
import {inject, observer} from 'mobx-react'


export DeviceOrientation = observer(({grid, onChange}) ->
  displayName: 'DeviceOrientation'
  div className: 'row middle between', ->
    text 'Orientation'
    div className: 'pt-select pt-minimal pt-inline', ->
      select onChange: onChange, value: grid.orientation, ->
        option key: 'portrait', value: 'portrait', "Portrait"
        option key: 'landscape', value: 'landscape', "Landscape"

)

export GridColumnUnits = observer((props) ->
  displayName: 'GridColumnUnits'
  div className: 'pt-select pt-minimal pt-inline pt-rtl', =>
    select onChange: props.onChange, value: props.value, =>
      option key: 'pixel', value: 'pixel_width', "px wdt"
      option key: 'units', value: 'column_count', "no."

)

