subject = require('../lib/nail-methods.js')
nail = require('nail-core').use(subject)
_ = require("underscore")
module.exports =
  'structure':
    setUp: (done) ->
      done()

    'augment is a function': (test) ->
      test.expect 1
      test.ok (_.isFunction subject.augment),
        "module must export a 'augment' method"
      test.done()

  "methods":
    setUp: (done) ->
      @classes = {}
      @classDefinition =
        methods:
          sampleMethod: () -> 'hello sweety'
      nail.to @classes, testClass: @classDefinition
      @instance = new @classes.testClass()
      done()

    "method created": (test) ->
      test.expect 2
      test.ok (_.isFunction @instance.sampleMethod),
        "'sampleMethod' must be a function"
      test.equal @instance.sampleMethod(), 'hello sweety',
        "should return 'hello sweety'"
      test.done()