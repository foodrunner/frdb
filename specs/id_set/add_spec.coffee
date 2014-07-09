IDSet = require ('../../src/id_set')

describe 'IDSet', ->
  describe 'add', ->

    it 'nothing for existing id', ->
      result = new IDSet()
      result.add('1')
      result.add('1')
      expect(result.count).toEqual(1)
      expect(result.ids['1']).toEqual(true)

    it 'id and increase count', ->
      result = new IDSet()
      result.add('1')
      result.add('2')
      expect(result.count).toEqual(2)
      expect(result.ids['1']).toEqual(true)
      expect(result.ids['2']).toEqual(true)