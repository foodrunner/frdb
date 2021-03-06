class Result
  constructor: (ids, db) ->
    @ids = ids
    @db = db

  sort: (sortFn) ->
    db = @db
    if sortFn?
      idsSortFn = (i, j) -> sortFn(db.idLookup[i], db.idLookup[j])
    else
      idsSortFn = null
    @ids.sort(idsSortFn)
    @

  get: (offset, count) ->
    offset = 0 unless offset?
    count = @ids.length unless count?
    return (@db.get(id) for id in @ids.slice(offset, offset + count))

  contain: (id) ->
    @ids.indexOf(id) isnt -1

module.exports = Result
