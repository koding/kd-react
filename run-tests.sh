#!/bin/bash

./node_modules/mocha/bin/mocha ./test/setup.coffee \
  ./src/**/test/*.coffee \
  --reporter spec \
  --ui bdd \
  --debug \
  --compilers coffee:coffee-react/register \
  --recursive
