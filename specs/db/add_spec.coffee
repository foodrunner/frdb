DB = require('../../src/db')
SetIndex = require('../../src/indexes/set_index')
TrieIndex = require('../../src/indexes/trie_index')

describe 'DB', ->
  describe 'add', ->

    it 'with multiple indexes', ->
      spyOn(SetIndex::, 'add')
      spyOn(TrieIndex::, 'add')
      db = new DB()
      db.createIndex('tags', 'set')
      db.createIndex('name', 'trie')
      index = {tags: ['1t', '3t'], name: 'Kentucky Fried Chicken'}
      db.add({id: 'id1'}, index)
      expect(db.idLookup['id1'].id).toEqual('id1')
      expect(SetIndex::.add).toHaveBeenCalledWith('id1', ['1t', '3t'])
      expect(TrieIndex::.add).toHaveBeenCalledWith('id1', 'Kentucky Fried Chicken')
