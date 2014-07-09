class Result
  constructor: (ids, db) ->
    @ids = ids
    @db = db

  sort: (sortFn) ->
    db = @db
    idsSortFn = (i, j) -> sortFn(db.idLookup[i], db.idLookup[j])
    @ids.sort(idsSortFn)
    @

  get: (offset, count) ->
    offset = 0 unless offset?
    count = @ids.length unless count?
    return (@db.get(id) for id in @ids.slice(offset, offset + count))

module.exports = Result
