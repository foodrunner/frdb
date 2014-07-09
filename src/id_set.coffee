class IDSet
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
    result = new IDSet()
    result.count = @count
    result.ids[id] = true for id, _ of @ids
    result

  @union: (sets) ->
    final = new IDSet()
    for result in sets
      final.add(id) for id of result.ids
    final

  @intersect: (sets) ->
    length = sets.length
    range = [1...length]
    sets.sort((r1, r2) -> r1.count - r2.count)
    final = new IDSet()
    for id, _ of sets[0].ids
      found = true
      for i in range
        unless sets[i].ids[id]?
          found = false
          break
      final.add(id) if found
    final

module.exports = IDSet
