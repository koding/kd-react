{ EventEmitter } = require 'events'
React = require 'react/addons'

###*
 * Takes a component and a selector(only tagName or className), and returns
 * that react component.
 *
 * @param {React.Component} component
 * @param {string} selector
 * @return {React.Component} child
###
$ = (component, selector) ->
  { findRenderedDOMComponentWithTag,
    findRenderedDOMComponentWithClass} = React.addons.TestUtils
  if selector[0] is '.'
    findRenderedDOMComponentWithClass component, selector.slice(1)
  else
    findRenderedDOMComponentWithTag component, selector


###*
 * Returns the classlist of given dom node.
 *
 * @param {DOMNode} node
 * @return {Array.<string>} classList
###
$.classList = (domNode) -> domNode.className.split ' '

noop = ->
noop.type = 'noop'


###*
 * Takes a component and injects an event emitter into lifecycle methods to be
 * able to test lifecycle methods, for convinience it emits the component
 * itself with the necessary event to be able to make assertions.
 *
 * it returns an object with 2 functions:
 *
 *   - `restore`: restores the object's method back to before.
 *   - `on`: simply a delegator to `EventEmitter::on`
 *
 * @param {function(new:React.Component)} Component
 * @return {object} injector
###
injectLifecycleHooks = (Component) ->

  methodNames = [
    'componentWillMount'
    'componentDidMount'
    'componentWillReceiveProps'
    'componentWillUpdate'
    'componentDidUpdate'
    'componentWillUnmount'
  ]

  emitter = new EventEmitter

  originals = {}

  methodNames.forEach (methodName) ->
    # default to noop so that we can still be able to
    # inject to missing lifecycle methods as well.
    originals[methodName] = _method = Component.prototype[methodName] or noop

    Component.prototype[methodName] = (args...) ->
      _method.apply this, args
      emitter.emit methodName, this

  ###*
   * Restore methods to their original forms.
  ###
  restore = ->
    for name, method of originals
      if method.type and method.type is 'noop'
        delete Component.prototype[name]
      else
        Component.prototype[name] = method

  _on = (args...) -> emitter.on args...

  return { restore, on: _on }


module.exports = TestUtils = {
  $
  injectLifecycleHooks
}

