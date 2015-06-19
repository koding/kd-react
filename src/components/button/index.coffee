React       = require 'react'
curry       = require 'classnames'
KDComponent = require '../../core/component'
KDLoader    = require '../loader'

noop = ->

module.exports = class KDButton extends KDComponent

  @propTypes      :
    callback      : React.PropTypes.func
    title         : React.PropTypes.string
    icon          : React.PropTypes.bool
    loader        : React.PropTypes.bool
    loaderOptions : React.PropTypes.object

  @defaultProps   :
    callback      : noop
    title         : null
    icon          : no
    loader        : no
    loaderOptions :
      length      : 0
      opacity     : 0
      radius      : 5
      width       : 2
      position    : 'relative'


  renderLoader: ->
    if @props.loader
      <span className="Button-loader">
        <KDLoader options={@props.loaderOptions} />
      </span>


  renderIcon: ->
    if @props.icon and not @props.loader
      <span className="Button-icon"></span>


  renderTitle: ->
    if @props.title and not @props.loader
      <span className='Button-title'>{@props.title}</span>


  render: ->
    className = curry 'Button', @props.className
    <button {...@props} className={className} onClick={@props.callback}>
      {@renderLoader()}
      {@renderIcon()}
      {@renderTitle()}
    </button>


