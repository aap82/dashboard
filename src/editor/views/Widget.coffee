{crel, div} = require 'teact'
{inject, observer} = require 'mobx-react'

{getWidget} = require '../../widgets'


Widget = observer(({widget, editor, state}) ->
  displayName: 'Widget'
  style = widget.style
  cardDepth = widget.cardDepth
  if !widget.overrideStyle
    style = editor.widgetStyleProps
    cardDepth = editor.widgetProps.cardDepth
  div id: widget.id, style: style, className: 'base-widget z-depth-' + cardDepth, ->
    getWidget(widget, state)


)



module.exports = inject('editor')(Widget)