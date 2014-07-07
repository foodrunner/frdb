TextIndex = require ('../../../src/indexes/text_index')

describe 'TextIndex', ->
  describe 'index', ->

    it 'not blacklist word', ->
      dict = new TextIndex()
      dict.index('1m', 'be')
      expect(dict.set._map).toEqual({})

    it 'word and its variants', ->
      spyOn(TextIndex, 'variants').andReturn(['word', 'words'])
      dict = new TextIndex()
      dict.index('1m', 'words')
      expect(dict.set._map['word'].count).toEqual(1)
      expect(dict.set._map['word'].ids['1m']).toEqual(true)
      expect(dict.set._map['words'].count).toEqual(1)
      expect(dict.set._map['words'].ids['1m']).toEqual(true)

    it 'an existing word', ->
      spyOn(TextIndex, 'variants').andReturn(['word'])
      dict = new TextIndex()
      dict.index('1m', 'word')
      dict.index('2m', 'word')
      expect(dict.set._map['word'].count).toBe(2)
      expect(dict.set._map['word'].ids['1m']).toBe(true)
      expect(dict.set._map['word'].ids['2m']).toBe(true)
