React         = require 'react/addons'
{ expect }    = require 'chai'
{ TestUtils } = React.addons

KDReactComponent = require '../component'

describe 'KDReactComponent', ->

  class FooComponent extends KDReactComponent
    render: -> <div {...@props} />

  it 'works', ->

    expect(<FooComponent />).to.be.ok


  describe 'include', ->

    it 'adds react mixins', ->

      flag = no
      mixin =
        componentDidMount: -> flag = yes
        getDefaultProps: -> { foo: 'bar' }

      class FooComponent extends KDReactComponent
        @include [mixin]
        render: -> <div />

      expect(FooComponent.defaultProps).to.eql { foo: 'bar' }

      component = TestUtils.renderIntoDocument(
        <FooComponent />
      )

      expect(flag).to.equal yes


  describe '#bound', ->

    it 'has KDObject::bound abilities', ->

      flag = no

      class BarComponent extends KDReactComponent
        constructor: (props) ->
          super props
          # this will prove that bound method works for
          # click handlers as it should. We are gonna assign
          # this instance variable to flag, and will test if flag has
          # this value.
          @instanceBoolean = yes

        onClick: (e) -> flag = @instanceBoolean
        render: -> <div onClick={@bound 'onClick'} />

      component = TestUtils.renderIntoDocument(
        <BarComponent />
      )

      element = TestUtils.findRenderedDOMComponentWithTag component, 'div'

      TestUtils.Simulate.click element

      expect(flag).to.equal yes


