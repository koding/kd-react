React = require 'react'
curry = require 'classnames'

KDComponent = require '../../core/component'

Spinner = require 'spin.js'

module.exports = class KDLoader extends KDComponent

  @propTypes    :
    options     : React.PropTypes.shape
      scale     : React.PropTypes.number
      lines     : React.PropTypes.number
      length    : React.PropTypes.number
      width     : React.PropTypes.number
      radius    : React.PropTypes.number
      corners   : React.PropTypes.number
      rotate    : React.PropTypes.number
      direction : React.PropTypes.oneOf([1, -1])
      color     : React.PropTypes.string
      speed     : React.PropTypes.number
      trail     : React.PropTypes.number
      shadow    : React.PropTypes.bool
      hwaccell  : React.PropTypes.bool
      className : React.PropTypes.string
      zIndex    : React.PropTypes.number
      top       : React.PropTypes.string
      left      : React.PropTypes.string


  componentDidMount: ->

    new Spinner(@props.options).spin @refs.spinner


  render: ->
    <div className={curry 'Loader', @props.className}>
      <span ref="spinner" className="Loader-Spinner" />
    </div>

