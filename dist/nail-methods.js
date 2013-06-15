(function() {
  var _;

  _ = require('underscore');

  module.exports.augment = function(newClass, definition, nail) {
    var _ref;
    definition.methods = (_ref = definition.methods) != null ? _ref : {};
    return _.extend(newClass.prototype, definition.methods);
  };

}).call(this);
