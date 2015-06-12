jsdom = require 'jsdom'

document = jsdom.jsdom('<html><body></body></html>')

beforeEach ->
  global.document = document
  global.window = document.parentWindow
