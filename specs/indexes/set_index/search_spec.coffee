SetIndex = require ('../../../src/indexes/set_index')

describe 'SetIndex', ->
  describe 'search', ->

    it 'for 1 key', ->
      set = new SetIndex()
      set.add('1m', ['1t', '2t'])
      set.add('2m', '2t')
      result = set.search('1t')
      expect(result.count).toEqual(1)
      expect(result.ids['1m']).toEqual(true)

    it 'for multiple keys', ->
      set = new SetIndex()
      set.add('1m', ['1t', '2t'])
      set.add('2m', '2t')
      result = set.search(['1t', '2t'])
      expect(result.count).toEqual(2)

    it 'returns no result', ->
      set = new SetIndex()
      set.add('1m', ['1t', '2t'])
      set.add('2m', '2t')
      result = set.search('3t')
      expect(result.count).toEqual(0)