IDSet = require ('../../src/id_set')

describe 'IDSet', ->
  describe 'intersect', ->

    it '2 sets without common ids', ->
      r1 = new IDSet(['1m', '2m'])
      r2 = new IDSet(['3m', '4m', '5m'])
      r = IDSet.intersect([r1, r2])
      expect(r.count).toBe(0)
      expect(r.ids).toEqual({})

    it '2 sets with some common ids', ->
      r1 = new IDSet(['1m', '2m'])
      r2 = new IDSet(['1m', '4m', '5m'])
      r = IDSet.intersect([r1, r2])
      expect(r.count).toBe(1)
      expect(r.ids['1m']).toBe(true)