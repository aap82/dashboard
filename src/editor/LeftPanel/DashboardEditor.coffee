React = require 'react'
{extendObservable, observable, toJS} = require 'mobx'
{crel, div, text, h5, h4, select, option, pureComponent,br } = require 'teact'
{inject, observer} = require 'mobx-react'

EditableText = require '../components/EditableText'






class DashboardEditor extends React.Component
  handleSave: (id, value) =>
    console.log id, value

  render: ->
    {editor} = @props
    {dashboard} = editor
    div style: {paddingLeft: 5, paddingRight: 5}, className: 'content', =>
      div style: {marginBottom: 8}, className: 'row center middle', =>
        h5 'Dashboard Properties'
      div style: {marginBottom: 8}, className: 'row between middle', =>
        div 'Columns'
        div dashboard.cols
      div style: {marginBottom: 8}, className: 'row between middle', =>
        div 'Row Height'
        div dashboard.rowHeight

module.exports = observer(DashboardEditor)





