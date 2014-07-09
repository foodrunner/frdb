// Generated by CoffeeScript 1.7.1
(function() {
  var IDSet;

  IDSet = (function() {
    function IDSet(ids) {
      var id, _i, _len;
      if (ids == null) {
        ids = [];
      }
      this.count = 0;
      this.ids = {};
      for (_i = 0, _len = ids.length; _i < _len; _i++) {
        id = ids[_i];
        this.add(id);
      }
    }

    IDSet.prototype.add = function(id) {
      if (this.ids[id]) {
        return;
      }
      this.ids[id] = true;
      ++this.count;
      return null;
    };

    IDSet.prototype.clone = function() {
      var id, result, _, _ref;
      result = new IDSet();
      result.count = this.count;
      _ref = this.ids;
      for (id in _ref) {
        _ = _ref[id];
        result.ids[id] = true;
      }
      return result;
    };

    IDSet.union = function(sets) {
      var final, id, result, _i, _len;
      final = new IDSet();
      for (_i = 0, _len = sets.length; _i < _len; _i++) {
        result = sets[_i];
        for (id in result.ids) {
          final.add(id);
        }
      }
      return final;
    };

    IDSet.intersect = function(sets) {
      var final, found, i, id, length, range, _, _i, _j, _len, _ref, _results;
      length = sets.length;
      range = (function() {
        _results = [];
        for (var _i = 1; 1 <= length ? _i < length : _i > length; 1 <= length ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this);
      sets.sort(function(r1, r2) {
        return r1.count - r2.count;
      });
      final = new IDSet();
      _ref = sets[0].ids;
      for (id in _ref) {
        _ = _ref[id];
        found = true;
        for (_j = 0, _len = range.length; _j < _len; _j++) {
          i = range[_j];
          if (sets[i].ids[id] == null) {
            found = false;
            break;
          }
        }
        if (found) {
          final.add(id);
        }
      }
      return final;
    };

    return IDSet;

  })();

  module.exports = IDSet;

}).call(this);