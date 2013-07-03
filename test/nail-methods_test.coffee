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
          secondMethod: () -> 'second'
      nail.to @classes, 'test', testClass: @classDefinition
      @instance = new @classes.testClass()
      done()

    "method created": (test) ->
      test.expect 3
      test.ok (_.isFunction @instance.sampleMethod),
        "'sampleMethod' must be a function"
      test.equal @instance.sampleMethod(), 'hello sweety',
        "should return 'hello sweety'"
      test.equal @instance.secondMethod(), 'second',
        "should return 'second'"
      test.done()

  "oveloading":
    setUp: (done) ->
      @classes = {}
      nail.to @classes, 'test',
        SampleClass:
          methods:
            overloadedMethod:
              0:  -> 'no parameters'
              1: (one) -> 'one parameter'
              n: () -> 'many parameters'
            excatlyTwo:2: -> "ok"

      @instance = new @classes.SampleClass()
      done()

    "overloaded methods are called": (test)->
      test.expect 5
      test.equals @instance.overloadedMethod(), 'no parameters'
      test.equals @instance.overloadedMethod(1), 'one parameter'
      test.equals @instance.overloadedMethod(1,2), 'many parameters'
      test.equals @instance.overloadedMethod(1,2,3), 'many parameters'
      test.equals @instance.overloadedMethod(1,2,3,4,5), 'many parameters'
      test.done()

    "exact argument number": (test) ->
      test.expect 2
      test.equals @instance.excatlyTwo(1,3), 'ok'
      test.throws (()=>@instance.excatlyTwo()),Error
      test.done()