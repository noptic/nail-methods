# nail-methods
# https://github.com/noptic/nail-methods
#
# Copyright (c) 2013 noptic
# Licensed under the MIT license.
_ = require 'underscore'
module.exports.augment = (newClass,definition,nail) ->
  definition.methods = definition.methods ? {}
  _.extend newClass.prototype, definition.methods
