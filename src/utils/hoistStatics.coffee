import hoistNonReactStatics from 'hoist-non-react-statics'

hoistStatics = (higherOrderComponent) =>
  (BaseComponent) =>
    NewComponent = higherOrderComponent(BaseComponent)
    hoistNonReactStatics(NewComponent, BaseComponent)
    NewComponent

export default hoistStatics
