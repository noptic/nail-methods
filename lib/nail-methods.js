(function() {
  var _;

  _ = require('underscore');

  module.exports = {
    section: 'methods',
    augment: function(newClass) {
      var name, value, _ref, _ref1;
      newClass.definition[this.section] = (_ref = newClass.definition[this.section]) != null ? _ref : {};
      _ref1 = newClass.definition[this.section];
      for (name in _ref1) {
        value = _ref1[name];
        if (_.isFunction(value)) {
          newClass.prototype[name] = value;
        } else if (_.isObject(value)) {
          newClass.prototype[name] = this.api.overload(value);
          newClass.prototype[name].overloads = value;
        } else {
          throw "ivalid method definition: " + name;
        }
      }
      return this;
    },
    api: {
      overload: function(overloads) {
        return function() {
          var argc;
          argc = arguments.length.toString();
          if (overloads[argc]) {
            return overloads[argc].apply(this, arguments);
          } else if (overloads['n']) {
            return overloads.n.apply(this, arguments);
          } else {
            throw new Error("no overload of " + name + " accepts " + arguments.length + " arguments");
          }
        };
      }
    }
  };

}).call(this);
