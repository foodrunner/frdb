IDSet = require('../id_set')

class SetIndex
  constructor: () ->
    @_map = {}

  add: (id, key) ->
    keys = if key instanceof Array then key else [key]
    for key in keys
      @_map[key] = new IDSet() unless @_map[key]?
      @_map[key].add(id)
    null

  search: (keys) ->
    return if @_map[keys]? then @_map[keys].clone() else new IDSet() unless keys instanceof Array
    sets = (@_map[key] for key in keys when @_map[key]?)
    IDSet.union(sets)

module.exports = SetIndex
