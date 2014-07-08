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

  search: (options, sortFn = null) ->
    results = []
    for option, value of options
      return empty unless @indexes[option]?
      r = @indexes[option].search(value)
      return empty if r.count == 0
      results.push(r)
    (@idLookup[id] for id, _ of Result.intersect(results).ids).sort(sortFn)

module.exports = DB