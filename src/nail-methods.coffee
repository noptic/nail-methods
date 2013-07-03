# nail-methods
# https://github.com/noptic/nail-methods
#
# Copyright (c) 2013 noptic
# Licensed under the MIT license.
_ = require 'underscore'
module.exports =
  section: 'methods'
  augment: (newClass) ->
    newClass.definition[@section] = newClass.definition[@section] ? {}
    for name,value of newClass.definition[@section]
      if (_.isFunction value)
        newClass::[name] = value
      else if ( _.isObject value)
        newClass::[name] = @api.overload value
        newClass::[name].overloads = value
      else throw "ivalid method definition: #{name}"
    return this

  api:
    overload: (overloads) ->
      return ()->
        argc = arguments.length.toString()
        if overloads[argc]
          return overloads[argc].apply(this,arguments)
        else if overloads['n']
          return overloads.n.apply(this,arguments)
        else throw new Error("no overload of #{name} accepts #{arguments.length} arguments")