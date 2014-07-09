IDSet = require('./id_set')
Result = require('./result')
SetIndex = require('./indexes/set_index')
TrieIndex = require('./indexes/trie_index')
TextIndex = require('./indexes/text_index')
PolygonIndex = require('./indexes/polygon_index')

empty = []

class DB
  constructor: () ->
    @idLookup = {}
    @indexes = {}

  createIndex: (name, type) ->
    return if @indexes[name]?
    switch type
      when "set" then @indexes[name] = new SetIndex()
      when "trie" then @indexes[name] = new TrieIndex()
      when "text" then @indexes[name] = new TextIndex()
      when "polygon" then @indexes[name] = new PolygonIndex()

  add: (item, index) ->
    @idLookup[item.id] = item
    @indexes[name].add(item.id, value) for name, value of index
    null

  search: (options) ->
    idsets = []
    for option, value of options
      return new Result(empty, @) unless @indexes[option]?
      r = @indexes[option].search(value)
      return new Result(empty, @) if r.count == 0
      idsets.push(r)
    new Result(Object.keys(IDSet.intersect(idsets).ids), @)

  list: () ->
    new Result(Object.keys(@idLookup), @)

  get: (id) ->
    return clone(@idLookup[id])

clone = (old) ->
  n = (if (old instanceof Array) then [] else {})
  for i, v of old
    n[i] = if typeof v is "object" then clone(v) else v
  return n

module.exports = DB