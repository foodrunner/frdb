Result = require('../result')

class SetIndex
  constructor: () ->
    @_map = {}

  add: (id, key) ->
    keys = if key instanceof Array then key else [key]
    for key in keys
      @_map[key] = new Result() unless @_map[key]?
      @_map[key].add(id)
    null

  search: (keys) ->
    return if @_map[keys]? then @_map[keys].clone() else new Result() unless keys instanceof Array
    results = (@_map[key] for key in keys when @_map[key]?)
    Result.union(results)

module.exports = SetIndex
