import WeatherIcons from 'react-weathericons'
import {crel, div } from 'teact'
import {observer} from 'mobx-react'



WeatherIcon = observer((props) ->
  iconProps =
    name: 'forecast-io-' + props.iconName
  iconProps.fixedWidth = props.fixedWidth if props.fixedWidth?
  iconProps.flip = props.flip if props.flip?
  iconProps.rotate = props.rotate if props.rotate?
  iconProps.size = props.size if props.size?
  iconProps.className =  props.className if props.className?
  div ->
    crel WeatherIcons, iconProps
)





export default WeatherIcon