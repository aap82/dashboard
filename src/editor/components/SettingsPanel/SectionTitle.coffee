import React from 'react'
import {crel, div, button, h5, h6,text} from 'teact'
import {inject, observer} from 'mobx-react'
import {extendObservable} from 'mobx'
import cx from 'classnames'
#import {AnimakitExpander} from 'animakit-expander'
import AnimakitExpander from 'animakit-expander'



SectionTitle = observer(class SectionTitle extends React.Component
  constructor: (props) ->
    super props
    extendObservable @, {isOpen: yes}
  togglePanel: =>
    console.log 'hi'
    @isOpen = !@isOpen

  render: ->
    {title} = @props
    div className: 'pt-dark', =>
      crel SectionTitleComp,
        expanded: @isOpen
        title: title
        onClick: @togglePanel

)





SectionTitleComp = observer((props) ->
  buttonClass = cx(
    "pt-menu-item": yes
    "pt-button": yes
    "pt-elevation-2": yes
    "pt-active": yes
    "pt-intent-none": yes
    "pt-icon-caret-down": yes
    "title-settings-panel": yes

  )
  div ->
    crel "button",
      type: 'button',
      className: buttonClass
      onClick: props.onClick, ->
        h6 style: {color: 'white'}, "#{props.title}"
)

export default SectionTitleComp