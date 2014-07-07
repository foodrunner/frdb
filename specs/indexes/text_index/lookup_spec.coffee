Result = require ('../../../src/result')
TextIndex = require ('../../../src/indexes/text_index')

describe 'TextIndex', ->
  describe 'lookup', ->

    it 'union variants of a token', ->
      dict = new TextIndex()
      dict.set._map['a'] = new Result(['1m'])
      dict.set._map['b'] = new Result(['2m'])
      spyOn(TextIndex, 'variants').andReturn(['a', 'b'])
      result = dict.search('a')
      expect(result.count).toEqual(2)
      expect(result.ids['1m']).toEqual(true)
      expect(result.ids['2m']).toEqual(true)

    it 'intersect tokens', ->
      dict = new TextIndex()
      dict.set._map['apple'] = new Result(['1m', '2m'])
      dict.set._map['juice'] = new Result(['2m', '3m', '4m'])
      result = dict.search('apple juice')
      expect(result.count).toEqual(1)
      expect(result.ids['2m']).toEqual(true)