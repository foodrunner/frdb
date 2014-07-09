DB = require('../../src/db')
IDSet = require('../../src/id_set')
Result = require('../../src/result')
SetIndex = require('../../src/indexes/set_index')
TrieIndex = require('../../src/indexes/trie_index')

describe 'DB', ->
  describe 'search', ->

    it 'all indexes search are called', ->
      spyOn(SetIndex::, 'search').andReturn(['1m', '3m'])
      spyOn(TrieIndex::, 'search').andReturn(['4m', '1m'])
      db = new DB()
      db.createIndex('tags', 'set')
      db.createIndex('name', 'trie')
      db.search({tags: '1t', name: 'KFC'})
      expect(SetIndex::.search).toHaveBeenCalledWith('1t')
      expect(TrieIndex::.search).toHaveBeenCalledWith('KFC')

    it 'sort function are caleed', ->
      spyOn(SetIndex::, 'search').andReturn(new IDSet(['1m', '5m', '3m']))
      spyOn(TrieIndex::, 'search').andReturn(new IDSet(['3m', '1m', '5m']))
      db = new DB()
      db.createIndex('tags', 'set')
      db.createIndex('name', 'trie')
      db.idLookup['1m'] = {id: '1m', value: 1}
      db.idLookup['3m'] = {id: '3m', value: 3}
      db.idLookup['5m'] = {id: '5m', value: 5}
      results = db.search({tags: '1t', name: 'KFC'}).sort((a, b) -> a.value - b.value).get()
      expect(results[0].id).toEqual('1m')
      expect(results[1].id).toEqual('3m')
      expect(results[2].id).toEqual('5m')
