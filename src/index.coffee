React = require 'react'
{ __spread: assign } = React
KDComponent = require './core/component'

KDReact = assign {}, React, Component: KDComponent

module.exports = KDReact
