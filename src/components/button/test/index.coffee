{ expect }    = require 'chai'
React         = require 'react/addons'
ReactDOM      = require 'react-dom'
{ TestUtils } = React.addons
KDButton      = require '../'

{ $ } = require '../../../../test/testutils'

describe 'KDButtonComponent', ->

  it 'works', ->
    expect(typeof KDButton).to.equal 'function'

  describe 'props', ->

    it 'has default css className of `Button`', ->

      button = TestUtils.renderIntoDocument(
        <KDButton className="Foo" />
      )

      domNode = ReactDOM.findDOMNode button

      expect($.classList domNode).to.contain 'Button'
      expect($.classList domNode).to.contain 'Foo'


    it 'uses callback prop to be called when clicked', ->

      flag = no
      onClick = -> flag = yes

      button = TestUtils.renderIntoDocument(
        <KDButton callback={onClick} />
      )

      instance = $ button, 'button'

      TestUtils.Simulate.click instance

      expect(flag).to.equal yes

    it 'uses title prop', ->

      button = TestUtils.renderIntoDocument(
        <KDButton title='foo' />
      )

      title = $ button, '.Button-title'
      _buttonInstance = $ button, 'button'

      expect(title.textContent).to.equal 'foo'
      expect(_buttonInstance.children.length).to.equal 1

      buttonWithoutTitle = TestUtils.renderIntoDocument(
        <KDButton />
      )

      _buttonInstance = $ buttonWithoutTitle, 'button'
      expect(_buttonInstance.children.length).to.equal 0


    it 'uses icon prop', ->

      button = TestUtils.renderIntoDocument(
        <KDButton icon={yes} />
      )

      icon = $ button, '.Button-icon'
      _buttonInstance = $ button, 'button'

      expect(icon).to.be.ok


    it 'uses loader prop', ->
      button = TestUtils.renderIntoDocument(
        <KDButton loader={yes} />
      )

      loader          = $ button, '.Button-loader'
      _buttonInstance = $ button, 'button'

      expect(loader).to.be.ok
      expect(_buttonInstance.children.length).to.equal 1


    it 'renders both title and icon together', ->

      button = TestUtils.renderIntoDocument(
        <KDButton title="Hello" icon={yes} />
      )

      title           = $ button, '.Button-title'
      icon            = $ button, '.Button-icon'
      _buttonInstance = $ button, 'button'

      expect(title).to.be.ok
      expect(icon).to.be.ok
      expect(_buttonInstance.children.length).to.equal 2


    it 'only renders loader if loader is set', ->

      button = TestUtils.renderIntoDocument(
        <KDButton title="Hello" icon={yes} loader={yes} />
      )

      buttonInstance = $ button, 'button'

      { children } = buttonInstance

      expect(children.length).to.equal 1
      expect(children[0].className).to.equal 'Button-loader'


  describe 'KDButton example', ->

    KDComponent = require '../../../core/component'
    class FooComponent extends KDComponent

      constructor: (props) ->

        super props

        @state = { loading: no }


      onButtonClick: ->

        @setState { loading: yes }

        setTimeout =>
          @setState { loading: no }
        , 1000


      render: ->
        <div>
          <h1>Hello World</h1>
          <KDButton
            loader={@state.loading}
            title="hello world"
            callback={@bound 'onButtonClick'}
            disabled={@state.loading}
          />
        </div>

    it 'renders in another component', ->

      foo = TestUtils.renderIntoDocument(
        <FooComponent />
      )

      button = $ foo, '.Button'

      expect(button).to.be.ok


