SetIndex = require ('../../../src/indexes/set_index')

describe 'SetIndex', ->
  describe 'add', ->

    it 'some ids', ->
      set = new SetIndex()
      set.add('1m', ['1t', '2t'])
      set.add('2m', '2t')
      expect(set._map['1t'].count).toEqual(1)
      expect(set._map['1t'].ids['1m']).toEqual(true)
      expect(set._map['2t'].count).toEqual(2)
      expect(set._map['2t'].ids['1m']).toEqual(true)
      expect(set._map['2t'].ids['2m']).toEqual(true)