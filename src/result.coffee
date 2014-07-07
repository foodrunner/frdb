class Result
  constructor: (ids = []) ->
    @count = 0
    @ids = {}
    @add(id) for id in ids

  add: (id) ->
    return if @ids[id]
    @ids[id] = true
    ++@count
    null

  clone: () ->
    result = new Result()
    result.count = @count
    result.ids[id] = true for id, _ of @ids
    result

  @union: (results) ->
    final = new Result()
    for result in results
      final.add(id) for id of result.ids
    final

  @intersect: (results) ->
    length = results.length
    range = [1...length]
    results.sort((r1, r2) -> r1.count - r2.count)
    final = new Result()
    for id, _ of results[0].ids
      found = true
      for i in range
        unless results[i].ids[id]?
          found = false
          break
      final.add(id) if found
    final

module.exports = Result
