class Widget
  constructor: (props = {}) ->
    @key = props.key or ''
    @label = props.label or 'Widget Label'
    @type = props.type or ''
    @attrNames = props.attrNames ?= {}
    @cardDepth = props.cardDepth or 2
    @style =
      backgroundColor: props.style?.backgroundColor or '#0900FF'
      borderRadius: props.style?.borderRadius or 2
      color: props.style?.color or 'white'
    @device =
      id: ''
      deviceId: ''
      platform: ''





module.exports = Widget