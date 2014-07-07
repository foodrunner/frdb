TrieIndex = require ('../../../src/indexes/trie_index')

describe 'TrieIndex', ->
  describe 'add', ->

    it 'all suffixes of a string', ->
      trie = new TrieIndex()
      trie.add(1, "Hard Rock Cafe")
      expect(trie.search("Cafe").count).toBe(1)
      expect(trie.search("Rock").count).toBe(1)
      expect(trie.search("Hard Rock Cafe").count).toBe(1)

    it 'words with multiple results when lookup', ->
      trie = new TrieIndex()
      trie.add(1, "Hard Rock Cafe")
      trie.add(2, "Band Rocking")
      trie.add(3, "Roc")
      expect(trie.search("roc").count).toBe(3)
      expect(trie.search("Rock").count).toBe(2)
      expect(trie.search("Cafe").count).toBe(1)
