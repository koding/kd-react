React         = require 'react/addons'
ReactDOM      = require 'react-dom'
KDLoader      = require '../'
{ expect }    = require 'chai'
{ TestUtils } = React.addons

{ $, injectLifecycleHooks } = require '../../../../test/testutils'

describe 'KDLoader', ->

  it 'works', ->

    expect(typeof KDLoader).to.equal 'function'


  describe 'props', ->

    it 'has default css className of `Loader`', ->

      loader = TestUtils.renderIntoDocument(
        <KDLoader className="ExtraClass" />
      )

      domNode = ReactDOM.findDOMNode loader
      expect($.classList domNode).to.contain 'Loader'
      expect($.classList domNode).to.contain 'ExtraClass'


  describe 'Spinner', ->

    injector = null
    beforeEach -> injector = injectLifecycleHooks KDLoader
    afterEach -> injector.restore()

    it 'shows a spinner after component got mounted', (done) ->

      injector.on 'componentDidMount', (_loader) ->

        spinner = $ _loader, '.Loader-Spinner'
        domNode = spinner

        expect(domNode.children.length).to.equal 1
        expect(domNode.children[0].className).to.equal 'spinner'

        done()

      loader = TestUtils.renderIntoDocument(<KDLoader />)


